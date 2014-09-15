class MatchTrait < ActiveRecord::Base
  has_many :match_attributes
  has_many :users, through: :match_attributes
end