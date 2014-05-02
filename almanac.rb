require "faraday"
require "json"

# configuration
api_key = "aece37e7e7a48995"
base_url = "http://api.wunderground.com/api/#{api_key}"

# which method
almanac_search = "/almanac/q/CO/Denver.json"

# HTTP stuff
http_response = Faraday.get(base_url + almanac_search)

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
