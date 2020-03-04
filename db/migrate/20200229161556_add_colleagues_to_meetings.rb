class AddColleaguesToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :colleagues, :text, array: true, default: []
  end
end
