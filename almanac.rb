

api_key = "aece37e7e7a48995"
base_url = "http://api.wunderground.com"

client = WundergroundSearch.new(base_url, api_key)
data = client.print_almanac_search("Denver", "CO")

puts "Results for Denver:"

puts "Average Low temp for today: #{data[:average_low]} F&eg;"
puts "Record Low temp for today: #{data[:record_low]} F"

puts "Average High temp for today: #{data[:average_high]} F"
puts "Record High temp for today: #{data[:record_high]} F"