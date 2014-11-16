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

   $(".turret_model").click(AddTurret);
   $(".ship_model").unbind("click");
   $.ajax({
      url: "unit_list",
      data: {
         'model'  : $(this).text()
      },
      type: 'POST',
      success: function(response) {
         $('#fleet').append("<div><p>" + response + "</p></div>");
         $(".ship_model").click(AddUnit);
      },
      error: function() {
         alert("Ajax Error");
         $(".ship_model").click(AddUnit);
      }
   });
}

function AddTurret() {
   var href = document.URL;
   var shipid = href.split('/').pop();
   $(".turret_model").unbind("click");
   $.ajax({
      url: "/build_unit",
      data: {
         'model'  : $(this).text(),
         'shipid' : shipid
      },
      type: 'POST',
      success: function(response) {
         $('#unit').append("<div><p>" + response + "</p></div>");
         $(".turret_model").click(AddTurret);
      },
      error: function() {
         alert("Ajax Error");
         $(".turret_model").click(AddTurret);
      }
   });
}
