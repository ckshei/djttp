class EventsController < ApplicationController
  def new
  end

  def create
    @event = Event.create(event_params(:name, :date, :host_id))
    @event.guests << current_user
    @event.create_playlist
    @event.save
    redirect_to event_path(@event) 
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
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
  end

  def guest
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

  def refresh_playlist
    event = Event.find(params[:id])
    event.refresh_playlist
    redirect_to event_path(event)
  end
  private

  def event_params(*args)
    params.require(:event).permit(*args)
  end
end
