class User < ActiveRecord::Base
  serialize :desc_words, Array
  validates_presence_of :email, :username, :personal_rank, :mic_style, :play_style, :desc_words
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false
end
