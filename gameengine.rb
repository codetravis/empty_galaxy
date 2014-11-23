require 'csv'
require 'mysql2'

module Engine

   class Game

      def initialize(gameid, map)
         
         # get the information about this game using its id from the db
         client = Mysql2::Client.new(:host => db_host, :database => db_name,
            :username => db_user, :password => db_password)
         # make new map from the dimensions passed in
      end
   end

   class Map
      def initialize(map_x, map_y)
         @map = Array.new(map_x * map_y, 0)
      end

      # check whether a map tile is open or not
      # returns unitid of occupying unit if occupied, else returns 0
      def view_tile(tile)
         unitid = @map[tile]
         return unitid
      end

      # put a unit on a tile in the map
      def place_unit(tile, unitid)
         old_tile = @map.fetch(unitid)
         if @map[tile] == 0
            @map[tile] = unitid
            @map[old_tile] = 0
            return true
         else
            return false
         end
      end
   end

   class Unit
      def initialize(unitid)
      end

      def move()
      end

   end


   class Weapon
      def initialize(weaponid)
      end

      def attack()
      end
   end

   def quick_game(userid)
      client = Mysql2::Client.new(:host => db_host, :database => db_name,
         :username => db_user, :password => db_password)

      # create new game in database
      client.query("INSERT INTO game (player_one, player_two) VALUES (#{userid}, 0)")
      gameid = client.last_id
      # load ships/turrets from csv into array and then build into db
      quick_list = CSV.read("game_data/quick_game.csv")
      num_turrets = 0
      
      # return gameid
   end
end
