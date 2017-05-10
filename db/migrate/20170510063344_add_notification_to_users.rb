class AddNotificationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notification_option, :boolean, default: true
  end
end
