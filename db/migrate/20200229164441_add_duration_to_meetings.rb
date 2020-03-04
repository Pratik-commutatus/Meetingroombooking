class AddDurationToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :duration, :integer
  end
end
