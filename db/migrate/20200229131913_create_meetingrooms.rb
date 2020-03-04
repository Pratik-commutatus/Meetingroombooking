class CreateMeetingrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :meetingrooms do |t|
      t.string :roomname
      t.integer :capacity

      t.timestamps
    end
  end
end
