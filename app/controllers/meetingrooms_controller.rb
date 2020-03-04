class MeetingroomsController < ApplicationController
  before_action :authenticate_user!
  before_action do 
    redirect_to new_user_session_path unless current_user && current_user.admin? 
  end 
  before_action :set_meetingroom, only: [:show, :edit, :update, :destroy]

  # GET /meetingrooms
  # GET /meetingrooms.json
  def index
    @meetingrooms = Meetingroom.all
    @users  = User.all

    @meetings = current_user.meetings.order(:date, :time)
    @meetingstoday = current_user.meetings.where(date: Date.today).order(:time)
    @meetingsattended = current_user.meetings.where("date < ?", Date.today).order(:date, :time)
    @meetingsupcoming = current_user.meetings.where("date > ?", Date.today).order(:date, :time)
  end

  # GET /meetingrooms/1
  # GET /meetingrooms/1.json
  def show
  end

  # GET /meetingrooms/new
  def new
    @meetingroom = Meetingroom.new
  end

  # GET /meetingrooms/1/edit
  def edit
  end

  # POST /meetingrooms
  # POST /meetingrooms.json
  def create
    @meetingroom = Meetingroom.new(meetingroom_params)

    respond_to do |format|
      if @meetingroom.save
        format.html { redirect_to @meetingroom, notice: 'Meetingroom was successfully created.' }
        format.json { render :show, status: :created, location: @meetingroom }
      else
        format.html { render :new }
        format.json { render json: @meetingroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetingrooms/1
  # PATCH/PUT /meetingrooms/1.json
  def update
    respond_to do |format|
      if @meetingroom.update(meetingroom_params)
        format.html { redirect_to @meetingroom, notice: 'Meetingroom was successfully updated.' }
        format.json { render :show, status: :ok, location: @meetingroom }
      else
        format.html { render :edit }
        format.json { render json: @meetingroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetingrooms/1
  # DELETE /meetingrooms/1.json
  def destroy
    @meetingroom.destroy
    respond_to do |format|
      format.html { redirect_to meetingrooms_url, notice: 'Meetingroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meetingroom
      @meetingroom = Meetingroom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meetingroom_params
      params.require(:meetingroom).permit(:roomname, :capacity)
    end
end
