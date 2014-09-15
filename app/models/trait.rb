class Trait < ActiveRecord::Base
  has_many :player_attributes
  has_many :users, through: :player_attributes
  validates_uniqueness_of :description, :case_sensitive => false
end