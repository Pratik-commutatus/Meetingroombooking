class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action do 
    redirect_to new_user_session_path unless current_user
  end
  helper :application
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index] 
  # GET /meetings
  # GET /meetings.json
  def index
    if current_user
    @meetings = current_user.meetings.order(:date, :time)

    @meetingstoday = current_user.meetings.where(date: Date.today).order(:time)
    @meetingsattended = current_user.meetings.where("date < ?", Date.today).order(:date, :time)
    @meetingsupcoming = current_user.meetings.where("date > ?", Date.today).order(:date, :time)
    end
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    respond_to do |format|
      if @meeting.save
        @meeting.users << current_user
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }

        ActionMailer::Base.smtp_settings = {
          :address              => "smtp.gmail.com",
          :port                 => 587,
          :user_name            => 'pratik@commutatus.com',
          :password             => 'lwlwfaildnhxxrln',
          :authentication       => "plain",
          :enable_starttls_auto => true
        }

        MeetingMailer.with(meeting: @meeting, users: @meeting.users.map {|x| x} ).new_meeting_email.deliver_now!
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    current_user.meetings.delete(@meeting)
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:date, :name, :time, :endtime, :meetingroom_id, :duration, user_ids: [])
    end
end
