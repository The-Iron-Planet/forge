class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :destroy]

  # GET /events
  def index
    if request.post?
      @events = Event.where("happens_on >= ?", Time.zone.now.beginning_of_day).ordered.
          search_results(params[:query], params[:campus_id])
      if @events.blank?
        flash.now[:notice] = "Your search returned no results. Please try again."
      elsif @events == Event
        @events = Event.where("happens_on >= ?", Time.zone.now.beginning_of_day).ordered.
            where(campus_id: current_user.campus_id)
        flash.now[:notice] = "Please choose specific search parameters."
        render :index
      end
    else
      @events = Event.where("happens_on >= ?", Time.zone.now.beginning_of_day).ordered.
        where(campus_id: current_user.campus_id)
    end
    @event = Event.new
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1
  def show
    @comment = Comment.new
  end

  # GET /events/1/edit
  def edit
  end

  def my_events
    @events = Event.where(user_id: current_user.id).ordered
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to my_events_path, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to my_events_path, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to root_path, notice: 'Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:title, :happens_on, :description, :website,
          :campus_id, :user_id, :uploaded_file, :location)
    end

    def check_user
      redirect_to root_path, notice: "You can only edit your own events!" unless @event.user_id == current_user.id
    end
end
