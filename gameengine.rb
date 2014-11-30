require 'csv'
require 'mysql2'

module Engine

   class Game

      def initialize(gameid, map, settings)
         
         @map = map

         # get the information about this game using its id from the db
         client = Mysql2::Client.new(:host => settings.db_host,
                                     :database => settings.db_name,
                                     :username => settings.db_user, 
                                     :password => settings.db_password)
         game = client.query("SELECT * FROM game WHERE gameid=#{gameid}",
            :symbolize_keys => true);

         # populate map from ship positions in database
         ships = client.query("SELECT * FROM ship WHERE gameid=#{gameid}", 
            :symbolize_keys => true);
         ships.each { |ship|
            @map.place_unit(ship[:position], ship[:shipid])
         }
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

   def self.quick_game(userid, settings)
      client = Mysql2::Client.new(:host => settings.db_host,
                                  :database => settings.db_name,
                                  :username => settings.db_user, 
                                  :password => settings.db_password)

      # create new game in database
      client.query("INSERT INTO game (player_one, player_two) VALUES (#{userid}, 0)")
      gameid = client.last_id
      load_ship_list(gameid, userid, "quick_game.csv", settings)
      load_ship_list(gameid, 0, "quick_game.csv", settings)

      # return gameid
      return gameid
   end

   def self.load_ship_list(gameid, userid, filename, settings)
      client = Mysql2::Client.new(:host => settings.db_host,
                                  :database => settings.db_name,
                                  :username => settings.db_user, 
                                  :password => settings.db_password)
      # load ships/turrets from csv into array and then build into db
      quick_list = CSV.read("game_data/" + filename)
      ship_data = Hash[CSV.read("game_data/ships.csv", :headers => true, :header_converters => :symbol).map{ |x| [x[:model], x[:max_armor]]}]
      shipid = 0
      pos_modifier = (userid == 0) ? 0 : 90
      quick_list.each { |row|
         if row[1].to_i > 0
            client.query("INSERT INTO ship (userid, gameid, model, direction, position, energy, armor, shield) VALUES (#{userid}, #{gameid}, '#{row[0]}', 1, #{shipid % 5 + pos_modifier}, 0, #{ship_data[row[0]].to_i}, 0)")
            shipid = client.last_id
         else
            client.query("INSERT INTO turret (shipid, model, energy) VALUES (#{shipid}, '#{row[0]}', 0)")
         end
      }

   end
end
