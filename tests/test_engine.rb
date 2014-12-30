require './models.rb'
require './gameengine.rb'
require 'data_mapper'

dbgame = Models::Game.create( :player_one => 0, :player_two => 1, :active_player => 0)
dbship = Models::Ship.create( :gameid => dbgame.gameid, :userid => 0, :xposition => 4, :yposition => 2)

mygame = GameEngine::ActiveGame.new(dbgame.gameid)
puts dbgame.gameid
mygame.map.each do |row|
   puts row.join(" ")
end

dbgame.destroy
dbship.destroy
