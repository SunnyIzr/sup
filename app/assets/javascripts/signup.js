var SignupController = {
  init: function(){
    this.activateSliders();
    this.activateTagCheckboxes();
    this.activateUnSlider();
    this.gameSelect();
    this.platformSelect();
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
  },
  gameSelect: function(){
    $("select[name='game_title']").change(function(e){
      SignupModel.getPlatforms()
    })
  },
  platformSelect: function(){
    $("select[name='platform_id']").change(function(e){
      SignupModel.getGame();
    })
  }
}

var SignupModel = {
  getPlatforms: function(){
    gameTitle = $("select[name='game_title']").val()
    url = '/games/platforms/' + gameTitle
    $.getJSON(url,function(platforms){
      SignupView.updatePlatforms(platforms)
    }) 
  },
  getGame: function(){
    url = '/games/find_game'
    gameTitle = $("select[name='game_title']").val()
    platformId = $("select[name='platform_id']").val()
    data = {game_title: gameTitle, platform_id: platformId}
    $.post(url,data,function(res){
      gameId = res.id
      SignupView.updateGame(gameId)
    })
  }
}

var SignupView = {
  changeHiddenRankInput: function(slider,value){
    $('#' + $(slider).data('target')).val(value)
  },
  updatePlatforms: function(platforms){
    $("select[name='platform_id']").html('')
    $.each(platforms,function(i,platform){
      option = "<option value='" + platform.id + "'>" + platform.name + "</option>"
      $("select[name='platform_id']").append(option)
    })
    SignupModel.getGame()
  },
  updateGame: function(gameId){
    $("select[name='user[game_id]']").val(gameId)
  }
}
