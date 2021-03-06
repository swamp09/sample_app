class User < ApplicationRecord
  has_many :microposts, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :room_join_users, dependent: :destroy, foreign_key: 'user_id'
  has_many :rooms, through: :room_join_users
  has_many :message, dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token

  before_save   :downcase_email
  before_create :create_activation_digest

  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: {maximum: 50, minimum: 5}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  has_secure_password

  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  validates :nickname, presence: true, length: {maximum: 50}, uniqueness: true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_columns(activated: true, activated_at: Time.current)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.current)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def follower_increase_notification(followed)
    UserMailer.follower_increase_notification(self, followed).deliver_now
  end

  def feed(search = ' ')
    following_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    Micropost.where("(user_id IN (#{following_ids}) OR user_id = :user_id OR in_reply_to = :nickname)AND content LIKE :search",
                      user_id: id, nickname: nickname, search: "%#{search}%")
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
    follower_increase_notification(other_user)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def at_nickname
    "@#{nickname}"
  end

  def mutual_followers?(other_user)
    following?(other_user) && other_user.following?(self)
  end

  def self.at_nickname_exist?(nickname)
    return false unless nickname = nickname.match(/(@.+)/)

    return false unless user = User.find_by(nickname: nickname[1].to_s[1..-1])

    user
  end

  def invite_room_exist?(other_user)
    rooms = self.rooms
    if rooms.any? {|room| room.users.find(other_user.id) }
      rooms.each {|room| room.users.find(other_user.id) }
    else
      false
    end
  end

  def self.search(search_text)
    search_text = '' unless search_text

    if user_nickname = search_text.match(/(@[^\s]+)/)
      where('nickname LIKE ? AND activated = ?', "%#{user_nickname[1].to_s[1..-1]}%", true)
    else
      where('name LIKE ? AND activated = ?', "%#{search_text}%", true)
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
