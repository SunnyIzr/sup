var SignupController = {
  init: function(){
    this.activateSliders();
    this.activateTagCheckboxes()
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
  }
}

var SignupView = {
  changeHiddenRankInput: function(slider,value){
    $('#' + $(slider).data('target')).val(value)
  }
}

var SignupModel = {
}