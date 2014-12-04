var switchLoginSignup = function(){
  $('.switchForm').click(function(e){
    e.preventDefault();
    hideEl = $(this).parent().parent();
    showEl = $(this).data('target');
    $(hideEl).hide();
    $(showEl).show();
  })
}

var closeOffCanvasFromNav = function(){
  $('.close-offcanvas-link').click(function(e){
    e.preventDefault();
    $('.exit-off-canvas').click()
  })
}

var submitContactForm = function(){
  $('.contact-us-btn').click(function(e){
    $('.contact-form').submit()
  })
}