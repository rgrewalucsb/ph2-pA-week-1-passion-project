require 'open-uri'
require_relative '../config/environment.rb'


module BartStation

	module Locations
		STATIONS = Hash[File.readlines(TXT_FILE).map{|line| [line[0..3],line[4..-1].strip] }]

		extend self
		def get(abbr) 
			STATIONS[abbr]
		end

		def list(full = false)
			if full
				STATIONS.values
			else 
				STATIONS.keys
			end
		end

	end

end

abbr = BartStation::Locations.list
station = BartStation::Locations.list(full=true)
stations = abbr.zip(station)
bart = stations.map! do |station|
	{
		abbr: station[0].upcase,
		name: station[1]
	}
end

bart.each do |x|
	Station.create(x)
end




