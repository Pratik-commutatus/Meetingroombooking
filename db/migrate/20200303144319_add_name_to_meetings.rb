class AddNameToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :name, :string
  end
end
