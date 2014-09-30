class OutsideActivity < ActiveRecord::Base
  has_many :preferred_activities
  has_many :users, through: :preferred_activities
  validates_uniqueness_of :description, :case_sensitive => false
end