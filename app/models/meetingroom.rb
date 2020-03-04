class Meetingroom < ApplicationRecord
    has_many :meetings, dependent: :destroy 
    has_many :users, through: :meetings, dependent: :destroy 

    validates :roomname, uniqueness: {message:"is not unique"}, presence: {message:"please enter something"}
    validates :capacity, presence: {message:"please enter something"}

end
