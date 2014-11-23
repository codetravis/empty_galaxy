// build_unit.js

$(document).ready(function() {
   $(".turret_model").click(AddTurret);
});

function AddTurret() {
   var href = document.URL;
   var shipid = href.split('/').pop();
   $(".turret_model").unbind("click");
   $.ajax({
      url: "/build_unit",
      data: {
         'model'  : $(this).attr('id'),
         'shipid' : shipid
      },
      type : 'POST',
      success: function (response) {
         $('#unit').append("<div><p>" + response + "</p></div>");
         $('.turret_model').click(AddTurret);
      },
      error: function(response) {
         alert("Ajax Error " + response);
         $('.turret_model').click(AddTurret);
      }
   });
}
