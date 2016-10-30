class EventsController < ApplicationController
  def index
  	if params[:search]
  		@events = Event.where('starts_at > ? and upper(name) like ? and published_at is not null', Time.now, "%" + params[:search].upcase + "%")
  	else
  		@events = Event.where('starts_at > ? and published_at is not null', Time.now)    
  	end
    
  end

  def my_event
    @events = Event.where(user_id: current_user.id)    
    render :template => "events/index"
  end

  def edit
    @event = Event.find(params[:id])
    @categories = Category.all
    @regions = Region.all
  end

  def new
    @event = Event.new
    @event.venue = Venue.new
    @event.venue.region = Region.first
    @event.category = Category.first
    @categories = Category.all
    @regions = Region.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to new_event_ticket_type_path(@event)
    else
      flash[:notice] = @event.errors.full_messages.to_sentence
      redirect_to :back
    end    
  end

  def update
    @categories = Category.all
    @regions = Region.all
    @event = Event.find(params[:id])    
    @event.category_id = event_params[:category_id]
    # @event.save
    if @event.update(event_params)
      flash[:success] = "Event successfully updated"
      redirect_to @event
    else
      flash.now[:error] = @event.errors.full_messages.to_sentence
      render action: 'edit'
    end
  end

  def publish
    if params[:id]
      event = Event.find(params[:id])
      if event && event.published_at.nil?
        if event.ticket_types.count > 0
          event.update(published_at: Time.now)        
          redirect_to event_path(event), flash: {success: 'Event has been published!'}
        else
          redirect_to :back, flash: {success: 'There is no ticket type for this event, you have to create at least one ticket type.'}
        end
        
      end
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :hero_image_url, :extended_html_description, :starts_at, :ends_at, :category_id, venue_attributes: [:name, :full_address, :region_id])
  end

end
