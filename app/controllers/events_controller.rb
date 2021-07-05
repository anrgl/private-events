class EventsController < ApplicationController
  def index
    @past_events = Event.past
    @future_events = Event.future
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to current_user
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :date)
  end
end
