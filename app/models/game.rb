class Game < ActiveRecord::Base
  belongs_to :platform
  validates_presence_of :title
  has_many :users
  
  def self.platforms(game_title)
    Game.where(title: game_title).map{ |game| game.platform }.uniq
  end
end