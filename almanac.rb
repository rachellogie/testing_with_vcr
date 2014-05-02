require "./wunderground_search"

wunderground_client = WundergroundSearch.new("aece37e7e7a48995", "http://api.wunderground.com/api")
temperature_data = wunderground_client.almanac_search("Denver", "CO")

# printing
puts "Results for Denver:"

puts "Average Low temp for today: #{temperature_data[:average_low_temp]} F"
puts "Record Low temp for today: #{temperature_data[:record_low_temp]} F"

puts "Average High temp for today: #{temperature_data[:average_high_temp]} F"
puts "Record High temp for today: #{temperature_data[:record_high_temp]} F"