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
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :all_incoming_messages, class_name: 'Message', foreign_key: 'recipient_id', dependent: :destroy
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', dependent: :destroy
  
  def generate_new_matches
    MatchAlgo.run(self).each { |match| Match.create(user: self, matched_user: match)}
  end
  
  def outstanding_matched_users
    requested_friends = self.requested_friend_requests.map { |fr| fr.recipient }
    self.matches.where(actioned: false).map{|match| match.matched_user }.select{|match| !requested_friends.include?(match) }
  end
  
  def age
    now = Time.now.utc.to_date
    now.year - self.date_of_birth.year - ((now.month > self.date_of_birth.month || (now.month == self.date_of_birth.month && now.day >= self.date_of_birth.day)) ? 0 : 1)
  end
  
  def location
    geo = Geokit::Geocoders::GoogleGeocoder.geocode(self.postal_code)
    "#{geo.city}, #{geo.state}"
  end
  
  def friend_requests
    friend_requests = self.incoming_friend_requests + self.requested_friend_requests
    friend_requests.sort_by {|fr| fr.updated_at }.reverse
  end
  
  def incoming_messages
    self.all_incoming_messages.where(deleted: false).sort_by{|message| message.created_at }.reverse
  end
  
  def deleted_messages
    self.all_incoming_messages.where(deleted: true).sort_by{|message| message.created_at }.reverse
  end
end
