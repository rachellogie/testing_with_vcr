require "faraday"
require "json"

class WundergroundSearch
  def initialize(api_key, base_url)
    @api_key = api_key
    @base_url = base_url
  end

  def almanac_search
    Faraday.get(almanac_search_url)
  end

  private

  def almanac_search_url
    "#{@base_url}/#{@api_key}/almanac/q/CO/Denver.json"
  end
end

wunderground_client = WundergroundSearch.new("aece37e7e7a48995","http://api.wunderground.com/api")

# HTTP stuff
http_response = wunderground_client.almanac_search

# parsing
parsed_response = JSON.parse(http_response.body)
average_low_temp = parsed_response["almanac"]["temp_low"]["normal"]["F"]
record_low_temp = parsed_response["almanac"]["temp_low"]["record"]["F"]
average_high_temp = parsed_response["almanac"]["temp_high"]["normal"]["F"]
record_high_temp = parsed_response["almanac"]["temp_high"]["record"]["F"]


# printing
puts "Results for Denver:"

puts "Average Low temp for today: #{average_low_temp} F"
puts "Record Low temp for today: #{record_low_temp} F"

puts "Average High temp for today: #{average_high_temp} F"
puts "Record High temp for today: #{record_high_temp} F"
