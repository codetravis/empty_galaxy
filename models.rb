require 'data_mapper'
require 'sinatra'
require 'sinatra/config_file'

config_file 'config.yml'
$settings = settings
module Models

   DataMapper::setup(:default, "mysql://#{$settings.db_user}:#{$settings.db_password}@#{$settings.db_host}/#{$settings.db_name}")

   # data model of a user
   class User
      include DataMapper::Resource

      property :userid,         Serial
      property :email,          String
      property :hashedpassword, String
      property :sessionid,      String
   end

   # data model of a game
   class Game
      include DataMapper::Resource

      property :gameid,        Serial
      property :player_one,    Integer
      property :player_two,    Integer
      property :active_player, Integer, :default => 0
   end

   # data model of a ship
   class Ship
      include DataMapper::Resource

      property :shipid,       Serial
      property :userid,       Integer
      property :gameid,       Integer
      property :ship_model,   String
      property :direction,    Integer
      property :xposition,    Integer
      property :yposition,    Integer
      property :battery,      Integer
      property :armor,        Integer
      property :shield,       Integer
   end

   # data model of a turret
   class Turret
      include DataMapper::Resource

      property :turretid,     Serial
      property :shipid,       Integer
      property :turret_model, String
      property :energy,       Integer
   end

   DataMapper.finalize
   DataMapper.auto_upgrade!
end
