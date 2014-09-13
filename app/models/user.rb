class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  serialize :desc_words, Array
  validates_presence_of :username, :email, :personal_rank, :mic_style, :play_style, :desc_words
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false
  has_many :availabilities
  has_many :time_slots, through: :availabilities
end
