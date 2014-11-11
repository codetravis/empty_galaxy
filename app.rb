require 'sinatra'
require 'mysql2'
require 'csv'

set :bind, '0.0.0.0'
set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

enable :sessions

helpers do
   
   def login?
      if session[:userid].nil?
         return false
      else
         return true
      end
   end

   def userid
      return session[:userid]
   end

end


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
   redirect "/"
end

post '/login' do
   hashed_password = params[:password] # later we will need to check the hashed version of the password 
   client = Mysql2::Client.new(:host => "localhost", 
      :database => "empty_galaxy", :username => "gameuser", :password => "test")
   user = client.query("SELECT userid FROM user WHERE email = '#{params[:email]}' and hashedpassword = '#{hashed_password}'").first
   if !user['userid']
      redirect "/"
   else
      session[:userid] = user['userid']
      erb :account, :locals => {'userid' => user['userid'], 'email' => params[:email]}
   end
end   

get '/logout' do
   # destroy cookies and sessions stuff
   erb :index
end

get '/build_unit/:shipid' do
   if login?
      # read in ships.csv file
      turrets = CSV.read("game_data/turrets.csv", :headers => true, :header_converters => :symbol)
      erb :build_unit, :locals => { :turrets => turrets}
   else
      redirect "/"
   end
end

post '/build_unit/:shipid' do
   if login?
      if not params[:shipid]
         redirect "/unit_list"
      end

      client = Mysql2::Client.new(:host => "localhost", 
         :database => "empty_galaxy", :username => "gameuser", :password => "test")
      turretid = client.query("INSERT INTO turret (shipid, model) VALUES (#{params[:shipid]}, '#{params[:model]}')")
      if params[:model].nil?
         "No turret model given for some reason"
      else
         "#{turretid} #{params[:model]}"
      end
   else
      redirect "/"
   end
end

get '/end_turn' do
   "ending turn for player"
end

get '/unit_list' do
   if login?
      # read in ships.csv file
      ships = CSV.read("game_data/ships.csv", :headers => true, :header_converters => :symbol)
      erb :unit_list, :locals => { :ships => ships}
      # also if fleet already exists, show ships in it (later subtract points of ships from total)
   else
      redirect "/"
   end
end

post '/unit_list' do
   client = Mysql2::Client.new(:host => "localhost", 
      :database => "empty_galaxy", :username => "gameuser", :password => "test")
   ship = client.query("INSERT INTO ship (userid, model) VALUES (#{userid}, '#{params[:model]}')")
   if params[:model].nil?
      "No ship model given for some reason"
   else
      "#{ship} #{params[:model]}"
   end
end
