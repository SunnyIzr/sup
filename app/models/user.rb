class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  serialize :desc_words, Array
  validates_presence_of :username, :email, :personal_rank, :mic_style, :play_style, :desc_words, :date_of_birth, :postal_code
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false
  has_many :availabilities
  has_many :time_slots, through: :availabilities
  has_many :player_attributes
  has_many :traits, through: :player_attributes
  has_many :match_attributes
  has_many :match_traits, through: :match_attributes
  belongs_to :game
  has_many :matches
  has_many :matched_users, through: :matches
  has_many :requested_friend_requests, class_name: 'FriendRequest', foreign_key: 'requester_id'
  has_many :incoming_friend_requests, class_name: 'FriendRequest', foreign_key: 'recipient_id' 
end
