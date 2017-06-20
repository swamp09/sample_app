class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table(:rooms, &:timestamps)
  end
end
