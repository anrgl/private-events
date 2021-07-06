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

  def edit
    @event = current_user.created_events.find(params[:id])
  end

  def update
    @event = current_user.created_events.find(params[:id])

    if @event.update(event_params)
      redirect_to current_user
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to root_path
  end

  def cancel_rsvp
    @event = Event.find(params[:id])
    @event.attendees.delete(current_user)

    redirect_to @event, notice: 'You are no longer attending this event'
  end

  def rsvp
    @event = Event.find(params[:id])
    if @event.attendees.include?(current_user)
      redirect_to @event, alert: 'You are alredy on the list'
    else
      @event.attendees << current_user
      redirect_to @event, notice: 'You are attending this event'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :date)
  end
end
