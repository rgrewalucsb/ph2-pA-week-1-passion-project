enable :sessions
# disable  :show_exceptions

get '/' do
  redirect '/user' if session[:user_id]
    @da = Station.find(13)
    @du = Station.find(15)
    @fr = Station.find(19)
    @ml = Station.find(26)
    @pt = Station.find(31)
    @rd = Station.find(34)
  @stations = Station.all
  erb :index
end

post '/eta' do
  session[:station] = params[:station]
  session[:destination] = params[:destination]
  session[:eta] = []
  transfer = false
  response = Bart::Realtime.etd(session[:station]).destinations
  response.map do |destination|
    if destination.abbr == session[:destination]
      destination.estimates.map do |estimate|
        session[:eta] << {
          minutes: estimate.minutes,
          platform: estimate.platform,
          direction: estimate.direction,
          length: estimate.length,
          color: estimate.color,
        }
      end
    else
    end
  end
  redirect '/'
end



get '/login'  do
	redirect '/user' if session[:user_id]
  erb :'/user/user_login'
end

post '/login' do
	user = User.find_by(username: params[:username])
  unless user
    session[:errors] = true
    redirect '/login'
  end
  if user.password == params[:password]
    session[:user_id] = user.id
    redirect '/user'
  else
    session[:errors] = user.errors.messages
    redirect '/login'
  end
end

get "/register" do
	redirect '/user' if session[:user_id]
  erb :'/user/user_register'
end



post "/register" do
  user = User.create(params[:user])
  if user.errors.any?
    session[:errors] = user.errors.messages
    redirect '/register'
  else
    redirect '/login'
  end
end


get '/user' do
  if session[:user_id]
    @da = Station.find(13)
    @du = Station.find(15)
    @fr = Station.find(19)
    @ml = Station.find(26)
    @pt = Station.find(31)
    @rd = Station.find(34)
    @stations = Station.all
    @user = User.find(session[:user_id])
    erb :'/user/user_index'
  else
    redirect '/'
  end
end

post '/user/eta' do
  if session[:user_id]
    session[:station] = params[:station]
    session[:destination] = params[:destination]
    if params[:remember] == 'true'
      @user = User.find(session[:user_id])
      @user.station = params[:station]
      @user.destination = params[:destination]
      @user.save
    end
    session[:eta] = []
    transfer = false
    response = Bart::Realtime.etd(session[:station]).destinations unless false
    response.map do |destination|
      if destination.abbr == session[:destination]
        destination.estimates.map do |estimate|
          session[:eta] << {
            minutes: estimate.minutes,
            platform: estimate.platform,
            direction: estimate.direction,
            length: estimate.length,
            color: estimate.color,
          }
        end
      else
      end
    end
  end
  redirect '/user'
end


get '/logout' do
  session.delete :user_id
  redirect '/'
end


configure do
  set :show_exceptions, false
end


not_found do
  request.path
end

error do
  session[:error] = "The Station you Entered Does NOT have a Train going to that Destination!"
  redirect '/'
end
