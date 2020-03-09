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
      errors.add(:user_ids, "Meeting Room Capacity Reached(#{cap})")
    end
  end

  def check_slot
    roomdatefind=Meeting.all.where("meetingroom_id= ? AND date= ?", meetingroom_id, date)
    c=roomdatefind.where("time<= ? AND endtime>= ?", time, endtime ).count
    d=roomdatefind.where("time>= ? AND endtime>= ?", time, endtime ).count
    e=roomdatefind.where("time<= ? AND endtime<= ?", time, endtime ).count
    f=roomdatefind.where("time>= ? AND endtime<= ?", time, endtime ).count
    g=roomdatefind.where("endtime>= ? AND time<= ?", time, endtime ).count
    if(c==0 && d==0 && e==0 && f==0 && g==0)
      
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
