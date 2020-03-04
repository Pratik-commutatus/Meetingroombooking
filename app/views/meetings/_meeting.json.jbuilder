json.extract! meeting, :id, :date, :time, :user_id, :meetingroom_id, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
