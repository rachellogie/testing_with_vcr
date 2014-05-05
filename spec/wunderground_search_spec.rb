require "spec_helper"
require "./wunderground_search"

describe WundergroundSearch do
  describe "#search_almanac" do
    it "returns some data from wunderground" do
      VCR.use_cassette("almanac") do
        wunderground_client = WundergroundSearch.new("aece37e7e7a48995", "http://api.wunderground.com/api")
        temperature_data = wunderground_client.almanac_search("Denver", "CO")

        expected_hash = {
          average_low_temp: 36,
          record_low_temp: 16,
          average_high_temp: 62,
          record_high_temp: 77
        }

        expect(temperature_data).to eq(expected_hash)
      end
    end
  end
end
