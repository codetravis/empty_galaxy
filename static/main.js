// main.js
// handles ajax connections to server

$(document).ready(function() {
   var httpRequest;

   $("#end_button").click(ChangePlayer);

});

function ChangePlayer() {
   $.ajax({
      url: "end_turn",
      type: 'GET',
      success: function(response) {
         $('#player_action').html("<div><p>" + response + "</p></div>");
      },
      error: function() {
         alert("Ajax Error");
      }
   });
}
