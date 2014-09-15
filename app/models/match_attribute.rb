class MatchAttribute < ActiveRecord::Base
  belongs_to :user
  belongs_to :match_trait
end