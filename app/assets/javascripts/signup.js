var SignupController = {
  init: function(){
    this.activateSliders();
  },
  activateSliders: function(){
    $('.slider').slider({
      value: 50,
      slide: function(e,ui){
        SignupView.changeHiddenRankInput(this,ui.value)
      }
    })
  }
}

var SignupView = {
  changeHiddenRankInput: function(slider,value){
    $('#' + $(slider).data('target')).val(value)
  }
}

var SignupModel = {
}