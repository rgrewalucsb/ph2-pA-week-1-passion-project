module Bart
	require 'active_support/all'
	require 'open-uri'

	BASE_URL = "http://api.bart.gov/api"
	API_KEY = "MW9S-E7SL-26DU-VV8V"

	module Realtime
		URL = "etd.aspx"

		extend self
		def etd(station)
			fetch("#{BASE_URL}/#{URL}?cmd=etd&orig=#{station}&key=#{API_KEY}")
		end

		def fetch(url)
			# Nokogiri::XML(open(url))
			Bart.parse_xml(open(url))
		end		
	end


	def self.parse_xml(xml)
		doc = Hash.from_xml(xml)
		
		response = BartResponse.new
		response.station = Station.from_hash(doc)
		response.destinations = doc['root']['station']['etd'].map { |d| Destination.from_hash(d) }

		response
	end


	BartResponse = Struct.new(:station, :destinations)


	Station = Struct.new(:name, :abbr) do
		def self.from_hash(hash)
			name = hash['root']['station']['name']
			abbr = hash['root']['station']['abbr']
			self.new(name, abbr)
		end
	end

	Destination = Struct.new(:name, :abbr, :estimates) do
		def self.from_hash(hash)
			name = hash['destination']
			abbr = hash['abbreviation']
			dest = self.new(name, abbr)

			dest.estimates = []

			hash['estimate'].each do |estimate|
				dest.estimates << Estimate.from_hash(estimate)
			end

			dest
		end
	end

	Estimate = Struct.new(:minutes, :platform, :direction, :length, :color) do
		def self.from_hash(hash)
			minutes = hash['minutes']
			platform = hash['platform']
			direction = hash['direction']
			length = hash['length']
			color = hash['color']

			self.new(minutes, platform, direction, length, color)
		end
	end
end


# response = Bart::Realtime.etd('MONT').destinations
# response.map do|destination|
# 	p destination.estimates if destination.abbr == 'DALY'
# end
trans = 0
x = 
Bart::Realtime.etd('BAYF').destinations.map {|d|  trans = 'BAYF' if d.abbr == 'DUBL'}
p trans

# p response.destinations.map(&:estimates).flatten.map(&:minutes).map(&:to_i).sort




