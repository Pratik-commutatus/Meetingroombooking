class MeetingMailer < ApplicationMailer
    helper :application
    default from: "pratik@commutatus.com"

    def new_meeting_email
        
        @meeting = params[:meeting]
        @users = params[:users]
    

        mail(to: @users.map{|u| u.email}, subject: "You got a new meeting!")
      end
end
