class EventsController < ApplicationController
  def new
  end

  def create
    @event = Event.create(event_params(:name, :date, :host_id))
    # @event.guests << current_user
    @event.create_playlist
    if @event.save
      render json: @event, status:201
    else
      render json: @event.errors
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params(:date))
    redirect_to event_path(@event)
  end

  def index
    if !current_user
      redirect_to new_user_path
    end
    @event = Event.new
    @events = current_user.events.all
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @events}
    end
  end

  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @event}
    end
  end

  def destroy
  end

  def rsvp
    event = Event.find(params[:id])
    current_user
    if event.guests.include?(@current_user)
      redirect_to event_path(event)
    else
      event.guests << @current_user
      event.save
      event.add_songs(@current_user)
      redirect_to event_path(event)
    end    
  end

  def guests
    event = Event.find(params[:id])
    @guests = event.guests
    respond_to do |format|
      format.json {render json: @guests}
    end
  end

  def playlist
    event = Event.find(params[:id])
    @playlist = event.playlist
    respond_to do |format|
      format.json {render json: @playlist, serializer: EventPlaylistSerializer}
    end
  end

  private

  def event_params(*args)
    params.require(:event).permit(*args)
  end
end
