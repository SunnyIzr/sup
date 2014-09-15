class Game < ActiveRecord::Base
  belongs_to :platform
  validates_presence_of :title
  has_many :users
end