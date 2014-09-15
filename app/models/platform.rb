class Platform < ActiveRecord::Base
  has_many :games
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
end