class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  serialize :desc_words, Array
  validates_presence_of :username, :personal_rank, :mic_style, :play_style, :desc_words, :date_of_birth, :postal_code, :gamertag, :occupation, :game_id
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false
  has_many :availabilities, dependent: :destroy
  has_many :time_slots, through: :availabilities
  has_many :player_attributes, dependent: :destroy
  has_many :traits, through: :player_attributes
  has_many :match_attributes, dependent: :destroy
  has_many :match_traits, through: :match_attributes
  has_many :preferred_activities, dependent: :destroy
  has_many :outside_activities, through: :preferred_activities
  belongs_to :game
  has_many :matches, dependent: :destroy
  has_many :matched_users, through: :matches
  has_many :requested_friend_requests, class_name: 'FriendRequest', foreign_key: 'requester_id', dependent: :destroy
  has_many :incoming_friend_requests, class_name: 'FriendRequest', foreign_key: 'recipient_id', dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  
  def generate_new_matches
    MatchAlgo.run(self).each { |match| Match.create(user: self, matched_user: match)}
  end
  
  def outstanding_matched_users
    self.matches.where(ignored: false).map{|match| match.matched_user }
  end
end
