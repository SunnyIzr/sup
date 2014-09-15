class Match < ActiveRecord::Base
  has_many :matched_users
  has_many :users, through: :matched_users
end