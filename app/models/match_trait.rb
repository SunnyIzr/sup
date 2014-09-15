class MatchTrait < ActiveRecord::Base
  has_many :match_attributes
  has_many :users, through: :match_attributes
  validates_uniqueness_of :description, :case_sensitive => false
end