class GamesController < ApplicationController
  def platforms
    render json: Game.platforms(params[:game_title]).to_json
  end
  def find_game
    @game = Game.where(title: params[:game_title], platform_id: title[:platform_id]).first
    render json: @game
  end
end