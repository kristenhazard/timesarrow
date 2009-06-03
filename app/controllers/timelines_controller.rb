class TimelinesController < ApplicationController
  require 'amazonecs'
  
  # GET /timelines
  # GET /timelines.xml
  def index
    @timelines = Timeline.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timelines }
    end
  end

  # GET /timelines/1
  # GET /timelines/1.xml
  def show
    @timeline = Timeline.find(params[:id])
    @item = flash[:item]
    @itemarrow = flash[:itemarray]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timeline }
    end
  end

  # GET /timelines/new
  # GET /timelines/new.xml
  def new
    @timeline = Timeline.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timeline }
    end
  end

  # GET /timelines/1/edit
  def edit
    @timeline = Timeline.find(params[:id])
  end

  # POST /timelines
  # POST /timelines.xml
  def create
    @timeline = Timeline.new(params[:timeline])

    respond_to do |format|
      if @timeline.save
        flash[:notice] = 'Timeline was successfully created.'
        format.html { redirect_to(@timeline) }
        format.xml  { render :xml => @timeline, :status => :created, :location => @timeline }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timeline.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /timelines/1
  # PUT /timelines/1.xml
  def update
    @timeline = Timeline.find(params[:id])

    respond_to do |format|
      if @timeline.update_attributes(params[:timeline])
        flash[:notice] = 'Timeline was successfully updated.'
        format.html { redirect_to(@timeline) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timeline.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /timelines/1
  # DELETE /timelines/1.xml
  def destroy
    @timeline = Timeline.find(params[:id])
    @timeline.destroy

    respond_to do |format|
      format.html { redirect_to(timelines_url) }
      format.xml  { head :ok }
    end
  end
  
  # timelines/add_item
  
  def add_item
    flash[:notice] = "add new item"
    @item = Item.new
    #render :partial => "search_item", :object => @item 
    flash[:item] = @item
    redirect_to :action => "show", :id => params[:id]
  end
  
  def search
    keywords = params[:keywords]
    if request.post?
      if keywords == ""
        flash[:error] = "Please enter keywords"
      else
        # amazon-ecs
        res = get_item_search_response(keywords)
        @error = res.error
        flash[:error] = @error
        @itemarray = res.items
      end
    end
    @item = Item.new
    flash[:item] = @item
    #flash[:itemarray] = @itemarray
    redirect_to :action => "show", :id => params[:id]
  end
end
