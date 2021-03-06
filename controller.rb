require 'sinatra'
require 'sinatra/activerecord'
set :database, "sqlite3:activeapp.sqlite3"
require './models/posts.rb'
enable  :sessions


get '/' do
	erb :index
end


post "/signup" do
    user = User.new(:name => params[:username], :password => params[:password])
    if user.save
        redirect "/login"
    else
        redirect "/failure/nosignup"
    end
end

get '/login' do
	@status = "Signup Successful"
	erb :index
end


post "/login" do
    user = User.find_by(:name => params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/success"
    else
        redirect "/failure/nologin"
    end
end


get '/success' do
	@status = "You're in!"
	@user = User.find_by(id: session[:user_id] )
	erb :location 
end


get '/failure/:event' do
	if params[:event] == "nologin"
		@status = "No Go. Try again"
		erb :index
	elsif params[:event] == "nosignup"
		@error = "Signup Unsuccessful"
		erb :index
	end
end

get '/logout' do
	session.clear
	erb :index
end






















get '/greet' do
	
    erb :greet
end





get '/location' do
    erb :location
end

post '/go' do
    @lat = params[:lat]
    @lon = params[:lon]
    erb :index

end



get '/post/:id' do 
	@post = Post.find(params[:id])
	erb :post
end