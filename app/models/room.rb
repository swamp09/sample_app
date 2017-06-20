class Room < ApplicationRecord
  has_many :room_join_users, dependent: :destroy, foreign_key: 'room_id'
  has_many :users, through: :room_join_users
  has_many :messages, dependent: :destroy

  def create_room(user1, user2)
    self.room_join_users.create!(user_id: user1.id)
    self.room_join_users.create!(user_id: user2.id)
  end
end
