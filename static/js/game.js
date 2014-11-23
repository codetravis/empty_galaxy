// Initialize Phaser and create a 640x640 game
var game = new Phaser.Game(640, 640, Phaser.CANVAS, 'game_div'
   { preload: preload, create: create, update: update });

function preload() {

   // Change the background color of the game
   game.stage.backgroundColor = '#000000';
   
   // Load the images that we need
   game.load.image('cruiser', '/assets/images/cruiser.png');
   game.load.image('frigate', '/assets/images/frigate.png');
   game.load.image('battleship', '/assets/images/battleship.png');

   game.load.image('move_tile', '/assets/images/move_tile.png');
   game.load.image('attack_tile', 'assets/images/attack_tile.png');
}

var BOARD_COLS = 10;
var BOARD_ROWS = 10;
var SHIP_SIZE  = 64;

function create() {
   // Function called after 'preload' to set up the game
   spawnShips();

}

function update() {
   // get updates on game from server and modify the map on move
}

function spawnShips() {
   // get fleets for both players and render on the board
}
