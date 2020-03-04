class AddEndtimeToMeeting < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :endtime, :time
  end
end
