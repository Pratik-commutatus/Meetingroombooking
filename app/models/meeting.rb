class Meeting < ApplicationRecord
  has_and_belongs_to_many :users
  # belongs_to :user
  belongs_to :meetingroom



  validate :check_cap

  validate :check_slot

  validate :check_time

  def check_cap
    k = Meetingroom.select(:capacity).where(id: meetingroom_id).pluck(:capacity)
    cap = k.join.to_i
    userscount = user_ids.count + 1
    if ( userscount > cap )
      errors.add("Meeting Room Capacity Reached (#{cap})")
    end
  end

  def check_slot
    c=Meeting.all.where("meetingroom_id= ? AND date= ? AND time<= ? AND endtime>= ?", meetingroom_id, date, time, endtime ).count
    if(c==0)
      
    else
      errors.add(:time, "Slot Booked")

    end
  end

  def check_time
    if(endtime <= time)
      errors.add(:endtime, "Cannot Book")
    end
  end



end
