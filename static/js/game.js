// Initialize Phaser and create a 640x640 game
var this_game = new Phaser.Game(640, 640, Phaser.CANVAS, 'game_div',
   { preload: preload, create: create, update: update });

function preload() {
   // Change the background color of the game
   this_game.stage.backgroundColor = '#000000';
   
   // Load the images that we need
   this_game.load.image('Cruiser', '/assets/images/cruiser.png');
   this_game.load.image('Frigate', '/assets/images/frigate.png');
   this_game.load.image('Battleship', '/assets/images/battleship.png');

   this_game.load.image('move_tile', '/assets/images/move_tile.png');
   this_game.load.image('attack_tile', '/assets/images/attack_tile.png');
}

var BOARD_COLS = 10;
var BOARD_ROWS = 10;
var SHIP_SIZE  = 64;
var TURN       = 0;
var GAMEID = document.URL.split('/').pop();
var USERID = 0; // need to get user id from hidden page field

function create() {
   // Function called after 'preload' to set up the game
   $.ajax({
      url: "/gamestate",
      data: {
         'gameid' : GAMEID
      },
      dataType: "json",
      type : 'GET',
      success: function(data){setupBoard(data);},
      error: function() {
         // give error message
      }
   });

}

function update() {
   // get updates on game from server and modify the map on move
   // check if it is my turn
   if (TURN != "0") {
      TURN = getTurn();
   }

   console.log(TURN);
   // if it is, lets take our turn

   // phase1 -- charge shields and weapons

   // phase2 -- move

   // phase3 -- attack

}

function setupBoard(game_info) {
   // get fleets for both players and render on the board
   ships = this_game.add.group();
   fleet = game_info["fleet"]
   game  = game_info["game"]
   turrets = game_info["turrets"]
   for(var i=0; i < fleet.length; i++)  {
      var obj = fleet[i];
      var y = Math.floor(obj["position"] / 10) * 64 + 32; // how many spots from top
      var x = (obj["position"] % 10) * 64 + 32; // how may spots from left
      this_ship = ships.create(x, y, obj["model"]);
      this_ship.anchor.set(0.5);
      this_ship.armor = obj["armor"];
      this_ship.shields = obj["shields"];
      this_ship.direction = obj["direction"];
   }
}

function getTurn() {
   var myturn = "";
   $.ajax({
      url: '/checkturn',
      data: {
         'gameid' : GAMEID
      },
      dataType: 'text',
      type: 'GET',
      success: function(data) {myturn = data},
      error: function() {}
   });
   return myturn
}
