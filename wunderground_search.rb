require "faraday"
require "json"

class WundergroundSearch
  def initialize(api_key, base_url)
    #config
    @api_key = api_key
    @base_url = base_url
  end

  def almanac_search(city, state)
    # http stuff
    http_response = Faraday.get(almanac_search_url(city, state))

    # parsing
    parse_response(http_response.body)
  end

  private

  def almanac_search_url(city, state)
    "#{@base_url}/#{@api_key}/almanac/q/#{state}/#{city}.json"
  end

  def parse_response(response_body)
    parsed_response = JSON.parse(response_body)

    average_low_temp = parsed_response["almanac"]["temp_low"]["normal"]["F"]
    record_low_temp = parsed_response["almanac"]["temp_low"]["record"]["F"]
    average_high_temp = parsed_response["almanac"]["temp_high"]["normal"]["F"]
    record_high_temp = parsed_response["almanac"]["temp_high"]["record"]["F"]

    {
      average_low_temp: average_low_temp.to_f,
      record_low_temp: record_low_temp.to_f,
      average_high_temp: average_high_temp.to_f,
      record_high_temp: record_high_temp.to_f
    }
  end
end