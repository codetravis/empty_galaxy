// Initialize Phaser and create a 640x640 game
var this_game = new Phaser.Game(640, 640, Phaser.CANVAS, 'game_div',
   { preload: preload, create: create, update: update });

function preload() {
   var href = document.URL;
   var gameid = href.split('/').pop();
   // Change the background color of the game
   this_game.stage.backgroundColor = '#000000';
   
   // Load the images that we need
   this_game.load.image('Cruiser', '/assets/images/cruiser.png');
   this_game.load.image('Frigate', '/assets/images/frigate.png');
   this_game.load.image('Battleship', '/assets/images/battleship.png');

   this_game.load.image('move_tile', '/assets/images/move_tile.png');
   this_game.load.image('attack_tile', '/assets/images/attack_tile.png');
   $.ajax({
      url: "/gamestate",
      data: {
         'gameid' : gameid
      },
      dataType: "json",
      type : 'GET',
      success: function(data){setupBoard(data);},
      error: function() {
         // give error message
      }
   });
}

var BOARD_COLS = 10;
var BOARD_ROWS = 10;
var SHIP_SIZE  = 64;

function create() {
   // Function called after 'preload' to set up the game

}

function update() {
   // get updates on game from server and modify the map on move
}

function setupBoard(game_info) {
   // get fleets for both players and render on the board
   ships = this_game.add.group();
   fleet = game_info["fleet"]
   game  = game_info["game"]
   turrets = game_info["turrets"]
   for(var i=0; i < fleet.length; i++)  {
      var obj = fleet[i];
      this_ship = ships.create(i * 64 + 32, i * 64 + 32, obj["model"]);
      this_ship.anchor.set(0.5);
      this_ship.armor = obj["armor"];
      this_ship.shields = obj["shields"];
      this_ship.direction = obj["direction"];
   }
}
