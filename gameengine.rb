$:.unshift File.dirname(__FILE__)
require 'csv'
require 'data_mapper'
require 'models'

module GameEngine

   class ActiveGame
      def initialize(gameid)
         @map = Array.new(10) {Array.new(10, 0)}
         @game = Models::Game.first(:gameid => gameid)
         # get ids of players in the game
         @players = [@game.player_one, @game.player_two]

         # populate map with ships connected to players in game
         @ships = Models::Ship.all(:gameid => gameid, :userid => @players).to_a
         @ships.each do |ship|
            @map[ship.yposition][ship.xposition] = ship.shipid
            puts "#{ship.shipid} #{ship.yposition} #{ship.xposition}"
         end

      end
      
      attr_reader :map, :game, :players, :ships

   end


   def move(unit, map, target)

      distance = calc_man_distance(unit.xposition, unit.yposition, target.xpos, target.ypos)

      # check for boundaries
      if distance > unit.speed
         return false
      elsif map[target.ypos][target.xpos] != 0
         return false
      else
         unit.yposition = target.ypos
         unit.xposition = target.xpos
         # save change to db
         Unit.first(:unitid => unit.unitid).update(:xposition => xpos, :yposition => ypos)
         return true
      end
   end

   def calc_man_distance(xpos, ypos, newx, newy)
      return 1
   end


end
