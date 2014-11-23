// unit_list.js

$(document).ready(function() {
   $('.ship_model').click(AddUnit);
});

function AddUnit() {
   $('.ship_model').unbind('click');
   $.ajax({
      url: 'unit_list',
      data: {
         'model': $(this).attr("id")
      },
      type: 'POST',
      success: function(response) {
         $('#fleet').append('<div><p>' + response + '</p></div>');
         $('.ship_model').click(AddUnit);
      },
      error: function(response) {
         alert('Ajax Error ' + response);
         $('.ship_model').click(AddUnit);
      }
   });
}
