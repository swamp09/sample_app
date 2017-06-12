class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  before_save { self.in_reply_to = reply_user }

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}

  validate :picture_size

  private

  def picture_size
    return errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
  end

  def reply_user
    return unless user_nickname = content.match(/(@[^\s]+)\s.*/)

    user_nickname[1].to_s[1..-1]
  end
end
