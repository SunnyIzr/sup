class GamesController < ApplicationController
  def platforms
    render json: Game.platforms(params[:game_title]).to_json
  end
end