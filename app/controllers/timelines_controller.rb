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
    keywords = params[:keywords]
    if !keywords.nil?
      if keywords == ""
        flash[:error] = "Please enter keywords"
      else
        # amazon-ecs
        res = get_item_search_response(keywords)
        @error = res.error
        flash[:error] = @error
        @itemarray = res.items
        @item = Item.new
        flash[:item] = @item
      end
    end

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
    flash[:item] = @item
    redirect_to :action => "show", :id => params[:id]
  end
  
  def select_item
    asin = params[:asin]
    res = get_item_lookup(asin)
    item = res.items[0]
    
    @item = Item.new
    @item.title = item.get("title")
    @item.itemtype = item.get("productgroup")
    @item.author = item.get("author")
    reviews = item/'editorialreview'
    if (!reviews.nil?)
      review = reviews[0]
      Amazon::Element.get_hash(review) # [:source => ..., :content ==> ...]
      @item.description = Amazon::Element.get_unescaped(review, 'content')
    else
      @item.description = ""
    end
    
    @item.asin = item.get("asin")
    @item.detailpageurl = item.get("detailpageurl")
    @item.smallimageurl = item.get("smallimage/url")
    @item.mediumimageurl = item.get("mediumimage/url")
    @item.publicationdate = item.get("publicationdate")
    @item.save
    
    @timeline_item = TimelineItem.new
    @timeline_item.item_id = @item.id
    @timeline_item.timeline_id = params[:id]
    @timeline_item.save
    @timeline_item.insert_at
    
    redirect_to :action => "show", :id => params[:id]
    
  end
  
  def sort
    params[:dtimeline].each_with_index do |id, index|
      TimelineItem.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
end