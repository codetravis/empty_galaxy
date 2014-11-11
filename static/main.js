// main.js
// handles ajax connections to server

$(document).ready(function() {
   var httpRequest;

   $("#end_button").click(ChangePlayer);
   $(".ship_model").click(AddUnit);
   $(".turret_model").click(AddTurret);

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

function AddUnit() {
   $.ajax({
      url: "unit_list",
      data: {
         'model'  : $(this).text()
      },
      type: 'POST',
      success: function(response) {
         $('#fleet').append("<div><p>" + response + "</p></div>");
      },
      error: function() {
         alert("Ajax Error");
      }
   });
}

function AddTurret() {
   var url = window.location.href;
   var shipid = url.substring(url.lastIndexOf('/') + 1);
   $.ajax({
      url: "build_unit/" + shipid,
      data: {
         'model'  : $(this).text()
      },
      type: 'POST',
      success: function(response) {
         $('#unit').append("<div><p>" + response + "</p></div>");
      },
      error: function() {
         alert("Ajax Error");
      }
   });
}
