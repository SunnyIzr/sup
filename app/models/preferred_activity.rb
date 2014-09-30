class PreferredActivity < ActiveRecord::Base
  belongs_to :user
  belongs_to :outside_activity
end