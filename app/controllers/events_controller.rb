class EventsController < ApplicationController
  
  # find event using db
  def find_event
    @event = Event.find(params[:id])
  end

  # get all events using db
  def get_all_events
    @events = Event.all
  end 

  # get event from cache
  def find_event_cached
    @event = Event.find_cached(params[:id])
  end

  # get all events from cache
  def get_all_events_cached
    @events = Event.all_cached
  end

  # check whether to use cache or db for find
  def check_cache_param_find
    if params[:usecache] == "true" 
      find_event_cached
    else
      find_event
    end
  end

  # check whether to use cache or db for Event.all
  def check_cache_param_all
    if params[:usecache] == "true" 
      get_all_events_cached
    else
      get_all_events
    end
  end

  # GET /events
  # GET /events.xml
  def index
    #@events = Event.all
    #@events = Event.all_cached
    check_cache_param_all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.json { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    #@event = Event.find(params[:id])
    #@event = Event.find_cached(params[:id])
    check_cache_param_find

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.json { render :json => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
      format.json { render :json => @event }
    end
  end

  # GET /events/1/edit
  def edit
    #@event = Event.find(params[:id])
    #@event = Event.find_cached(params[:id])
    check_cache_param_find
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
        format.json { render :json => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.json  { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    #@event = Event.find(params[:id])
    #@event = Event.find_cached(params[:id])
    check_cache_param_find

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.json  { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
end
