class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'room_channel'
  end

  def speak(payload)
    Message.create(user_id: current_user.id, room_id: payload['message']['room_id'], content: payload['message']['message'])
  end
end
