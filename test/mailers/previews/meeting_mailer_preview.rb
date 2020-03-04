# Preview all emails at http://localhost:3000/rails/mailers/meeting_mailer
class MeetingMailerPreview < ActionMailer::Preview
    def new_meeting_email
        # Set up a temporary order for the preview
      
        MeetingMailer.with(meeting: Meeting.last, users: User.last).new_meeting_email
      end
end
