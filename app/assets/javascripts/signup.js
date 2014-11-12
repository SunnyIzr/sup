var SignupController = {
  init: function(){
    this.activateSliders();
    this.activateSliderRanges();
    this.activateTagCheckboxes();
    this.activateUnSlider();
    this.gameSelect();
    this.platformSelect();
    this.directionSliderBtns();
    this.dayTimeSelector();
    this.confirmDayTimeSelector();
  },
  activateSliders: function(){
    $('.slider').slider({
      value: 50,
      slide: function(e,ui){
        SignupView.changeHiddenRankInput(this,ui.value)
      }
    })
  },
  activateSliderRanges: function(){
    $('.slider-range').slider({
      range: true,
      values: [6,18],
      min: 0,
      max: 23,
      slide: function(e,ui){
        SignupView.updateTimeRange($(this).parent().find('.time-range'),ui.values)
      }
    })    
  },
  activateTagCheckboxes: function(){
   $('.tag_checkboxes').buttonset() 
   $('.ui-corner-right').removeClass('ui-corner-right');
   $('.ui-corner-left').removeClass('ui-corner-left')
  },
  activateUnSlider: function(){
    SignupController.slider = $('.banner').unslider({
      speed: 500,               //  The speed to animate each slide (in milliseconds)
      delay: 99999999999999999,              //  The delay between slide animations (in milliseconds)
      complete: function() {},  //  A function that gets called after every slide animation
      keys: true,               //  Enable keyboard (left, right) arrow shortcuts
      dots: true,               //  Display dot navigation
      fluid: false              //  Support responsive design. May break non-responsive designs
    }).data('unslider');
  },
  directionSliderBtns: function(){
    $('.unslider-arrow').click(function(e){
      dir = $(this).data('direction')
      if ( dir == 'next'){
        SignupController.slider.next()
      } else if ( dir == 'prev' ){
        SignupController.slider.prev()
      }
    })
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
  },
  dayTimeSelector: function(){
    $('.play-schedule-select .day').click(function(e){
      $(this).addClass('selected')
      
      $(this).off()
      SignupView.updateHiddenTimeRanges(this)
    })
  },
  confirmDayTimeSelector: function(){
    $('.confirm-day').click(function(e){
      e.preventDefault();
      $($(this).parent()).removeClass('selected')
      $($(this).parent()).find('.time-range').addClass('show-time-range')
    })
  },
  slider: null
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
  },
  getTime: function(value){
    if(value == 0){
      return '12am'
    } else if (value <= 12) {
      return value + 'am'
    } else {
      return (value - 12) + 'pm'
    }
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
  },
  updateTimeRange: function(el,values){
    $(el).find('.startTime').html(SignupModel.getTime(values[0]))
    $(el).find('.start_time').val(values[0])
    $(el).find('.endTime').html(SignupModel.getTime(values[1]))
    $(el).find('.end_time').val(values[1])
  },
  updateHiddenTimeRanges: function(el){
    $(el).find('.start_time').val(6)
    $(el).find('.end_time').val(18)
  }
}
