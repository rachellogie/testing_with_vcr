require "spec_helper"
require "./wunderground_search"

describe WundergroundSearch do
  describe "#search_almanac" do

    before do
      stub_request(:get, %r{http://api.wunderground.com/api}).
        to_return(body: File.read(File.expand_path("./spec/support/almanac_response.json")))
    end

    it "returns some data from wunderground" do

      wunderground_client = WundergroundSearch.new("aece37e7e7a48995", "http://api.wunderground.com/api")
      temperature_data = wunderground_client.almanac_search("Denver", "CO")

      expected_hash = {
        average_low_temp: 50,
        record_low_temp: 42,
        average_high_temp: 66,
        record_high_temp: 89
      }

      expect(temperature_data).to eq(expected_hash)
    end
  end
end
