class Trait < ActiveRecord::Base
  has_many :player_attributes
  has_many :users, through: :player_attributes
end