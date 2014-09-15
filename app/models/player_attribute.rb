class PlayerAttribute < ActiveRecord::Base
  belongs_to :user
  belongs_to :trait
end