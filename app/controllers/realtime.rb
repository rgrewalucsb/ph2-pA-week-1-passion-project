require_relative '../models/etd.rb'



get '/realtime' do
	estimated_time = Etd.new(station: @station, destination: @destination)
	"#{estimated_time.etd_station}"
	
end