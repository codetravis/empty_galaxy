require 'sinatra'
require 'mysql2'

set :bind, '0.0.0.0'
set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
   erb :index
end

get '/register' do
   erb :register
end

post '/register' do
   hashed_password = params[:password] # later we will hash the password before storage 
   client = Mysql2::Client.new(:host => "localhost", 
      :database => "empty_galaxy", :username => "gameuser", :password => "test")
   client.query("INSERT INTO user (email, hashedpassword) VALUES ('#{params[:email]}', '#{hashed_password}')")
   erb :index
end

post '/login' do
   hashed_password = params[:password] # later we will need to check the hashed version of the password 
   client = Mysql2::Client.new(:host => "localhost", 
      :database => "empty_galaxy", :username => "gameuser", :password => "test")
   user = client.query("SELECT userid FROM user WHERE email = '#{params[:email]}' and hashedpassword = '#{hashed_password}'").first
   erb :account, :locals => {'userid' => user['userid'], 'email' => params[:email]}
end   

get '/build_ship' do
   erb :build_ship
end

get '/end_turn' do
   "ending turn for player"
end

get '/unit_list' do
   "UNIT LIST"
end
