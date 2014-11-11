class GamesController < ApplicationController
  def platforms
    render json: Game.platforms(params[:game_title]).to_json
  end
  def find_game
    @game = Game.where(title: params[:game_title], platform_id: params[:platform_id].to_i).first
    render json: @game.to_json
  end
end