$:.unshift File.dirname(__FILE__)
require 'csv'
require 'data_mapper'
require 'models'

module GameEngine

   class ActiveGame
      def initialize(gameid)
         @map = Array.new(10, Array.new(10, 0))

         # populate map with ships connected to players in game
      end
      
      attr_reader :map

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
