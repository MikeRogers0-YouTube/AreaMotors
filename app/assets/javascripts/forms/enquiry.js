$(document).on('turbolinks:load', function(){
  $('.form-group.enquiry_custom_state').showWhenThis( {
    evaluator_callback: function(){ return $('#enquiry_state option:checked').val() === 'custom' },
    change_selector: $('#enquiry_state')
  });
});
