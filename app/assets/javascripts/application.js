// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(document).ready(function() {
  $(".hotel_image").hover(function() {
    $(this).addClass('enlarge');
  },
  function(){
    $(this).removeClass('enlarge');
  }
  );
});

$(document).ready(function() {
  $(document).on('click', '.remove_fields', function(event){
    $(this).prev('input[type=hidden').val('1')
    $(this).closest('fieldset').hide()
  });
});

$(document).ready(function() {
  $(document).on('click', '.add_fields', function(event){
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
  });
});






