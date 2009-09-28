class TimelinesController < ApplicationController
  require 'amazonecs'
  
  before_filter :authorize, :except => [:index, :show, :featured, :books, :makeone]
  
  def index
    @timelines = Timeline.all(:include => [ :items, :timeline_items ], 
                              :order => 'category, subcategory, genre, featured desc')
    self.title = "TIME'S ARROW - All Timelines"
  end


  def show
    @timeline = Timeline.find(params[:id], :include => [ :items, :timeline_items ])
    @featured_timeline_item = @timeline.timeline_items[0]
    self.title = "TIME'S ARROW: " + @timeline.name + " timeline"
  end


  def new
    @timeline = Timeline.new
    self.title = "TIME'S ARROW - create new timeline"
  end

  # GET /timelines/1/edit
  def edit
    @timeline = Timeline.find(params[:id])
    self.title = "TIME'S ARROW edit " + @timeline.name + " timeline"
    keywords = params[:keywords]
    if !keywords.nil?
      if keywords == ""
        flash[:error] = "Please enter keywords"
      else
        # amazon-ecs
        category = @timeline.category
        res = get_item_search_response(keywords, category)
        @error = res.error
        flash[:error] = @error
        @itemarray = res.items
        #logger.info @itemarray
        @item = Item.new
        flash[:item] = @item
      end
    end
  end

  # POST /timelines
  # POST /timelines.xml
  def create
    @timeline = Timeline.new(params[:timeline])
    if @timeline.save
      flash[:notice] = 'Timeline was successfully created.'
      redirect_to edit_timeline_path(@timeline) 
    else
      render :action => "new" 
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
  
  # select item from amazon search and save into timeline
  def select_item
    asin = params[:asin]
    # get response from amazon 
    #res = get_item_lookup(asin)
    searchitem = get_item_lookup(asin).items[0]
    @item = Timeline.save_item_from_search(searchitem)
    Timeline.save_timeline_item_from_search(@item, params[:id])
    
    redirect_to :action => "edit", :id => params[:id]
    
  end
  
  def featured
    @timelines = Timeline.find_all_by_featured(1, :order => 'subcategory, genre', :include => [ :items, :timeline_items ])
    self.title = "TIME'S ARROW - Featured Timelines"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timelines }
    end
  end
  
  def makeone
    self.title = "TIME'S ARROW - Make a timeline"
  end
  
  def books
    @timelines = Timeline.find_all_by_category_and_subcategory('Book', params[:sub], :order => 'genre', :include => [ :items, :timeline_items ] )
    @headertitle = "TIME'S ARROW - Book " + params[:sub]
    @contenttitle = 'Book ' + params[:sub]
    self.title = @headertitle
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timelines }
    end
  end
  
end
