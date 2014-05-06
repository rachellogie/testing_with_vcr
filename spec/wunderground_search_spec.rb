require "spec_helper"
require "faraday"
require "json"

class WundergroundSearch

  attr_reader :api_key, :base_url

  def initialize(base_url, api_key)
    @base_url = base_url
    @api_key = api_key
  end

  def almanac_search(city, state)
    http_response = Faraday.get(almanac_url(city, state))
    parse_response(http_response)
  end

  private

  def parse_response(http_response)
    parsed_response = JSON.parse(http_response.body)

    {
      average_low: parsed_response["almanac"]["temp_low"]["normal"]["F"].to_f,
      record_low: parsed_response["almanac"]["temp_low"]["record"]["F"].to_f,
      average_high: parsed_response["almanac"]["temp_high"]["normal"]["F"].to_f,
      record_high: parsed_response["almanac"]["temp_high"]["record"]["F"].to_f
    }
  end

  def almanac_url(city, state)
    url + "/almanac/q/#{state}/#{city}.json"
  end

  def url
    base_url + "/api/" + api_key
  end
end

describe WundergroundSearch do
  describe "#search_almanac" do
    it "returns almanac data" do

      VCR.use_cassette("almanac") do

        api_key = "aece37e7e7a48995"
        base_url = "http://api.wunderground.com"

        client = WundergroundSearch.new(base_url, api_key)

        expected = {
          average_low: 37.0,
          record_low: 25.0,
          average_high: 64.0,
          record_high: 82.0
        }

        expect(client.almanac_search("Denver", "CO")).to eq(expected)
      end
    end
  end
end
