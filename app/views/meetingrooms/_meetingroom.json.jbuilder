json.extract! meetingroom, :id, :roomname, :capacity, :created_at, :updated_at
json.url meetingroom_url(meetingroom, format: :json)
