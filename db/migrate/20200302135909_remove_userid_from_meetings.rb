class RemoveUseridFromMeetings < ActiveRecord::Migration[6.0]
  def change

    remove_column :meetings, :user_id, :integer
  end
end
