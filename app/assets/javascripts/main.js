$(document).ready(function(){
  SignupController.init()
  switchLoginSignup();
  closeOffCanvasFromNav();
  openSupNotifications();
})

openSupNotifications = function(){
  $('.open-sups').click(function(e){
    e.preventDefault();
    $("#notificationContainer").fadeToggle(300);
  })
}