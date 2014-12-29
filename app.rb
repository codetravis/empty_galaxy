$:.unshift File.dirname(__FILE__)
require 'sinatra'
require 'sinatra/content_for'
require 'sinatra/config_file'
require 'mysql2'
require 'csv'
require 'json'
require 'models'
require 'gameengine'

config_file 'config.yml'

set :bind, '0.0.0.0'
set :port, 8080
set :static, true
set :public_folder, File.dirname(__FILE__) + "/static"
set :views, "views"

enable :sessions

get '/' do
   erb :index
end

