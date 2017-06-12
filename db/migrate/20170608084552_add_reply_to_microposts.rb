class AddReplyToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :in_reply_to, :string, default: ''
    add_index :microposts, :in_reply_to
  end
end
