var SignupController = {
  init: function(){
    this.activateSliders();
    this.activateTagCheckboxes();
    this.activateUnSlider();
  },
  activateSliders: function(){
    $('.slider').slider({
      value: 50,
      slide: function(e,ui){
        SignupView.changeHiddenRankInput(this,ui.value)
      }
    })
  },
  activateTagCheckboxes: function(){
   $('.tag_checkboxes').buttonset() 
  },
  activateUnSlider: function(){
    $('.banner').unslider({
      speed: 500,               //  The speed to animate each slide (in milliseconds)
      delay: 99999999999999999,              //  The delay between slide animations (in milliseconds)
      complete: function() {},  //  A function that gets called after every slide animation
      keys: true,               //  Enable keyboard (left, right) arrow shortcuts
      dots: true,               //  Display dot navigation
      fluid: false              //  Support responsive design. May break non-responsive designs
    });
  }
}

var SignupView = {
  changeHiddenRankInput: function(slider,value){
    $('#' + $(slider).data('target')).val(value)
  }
}

var SignupModel = {
}