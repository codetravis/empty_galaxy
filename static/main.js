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
   var href = document.URL;
   var shipid = href.split('/').pop();
   $.ajax({
      url: "/build_unit",
      data: {
         'model'  : $(this).text(),
         'shipid' : shipid
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
