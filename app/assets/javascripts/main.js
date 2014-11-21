$(document).ready(function(){
  SignupController.init()
  switchLoginSignup();
  closeOffCanvasFromNav();
  openSupNotifications();
  if ( $('#loadNotificationModule').size() > 0) {
    setTimeout(function(){
      openSupNotificationsAndMenu()
    },300)
  }
})

openSupNotifications = function(){
  $('.open-sups').click(function(e){
    e.preventDefault();
    $("#notificationContainer").fadeToggle(300);
  })
}

openSupNotificationsAndMenu = function(){
  $('.right-off-canvas-toggle').click()
  $("#notificationContainer").fadeToggle(300);
}