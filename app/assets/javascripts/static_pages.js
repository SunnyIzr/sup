var switchLoginSignup = function(){
  $('.switchForm').click(function(e){
    e.preventDefault();
    hideEl = $(this).parent().parent();
    showEl = $(this).data('target');
    $(hideEl).hide();
    $(showEl).show();
  })
}