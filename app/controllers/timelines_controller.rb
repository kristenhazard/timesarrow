class TimelinesController < ApplicationController
  require 'amazonecs'
  
  before_filter :authorize, :except => [:index, :show, :featured, :filtered, :makeone]
  
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


  def edit
    @timeline = Timeline.find(params[:id])
    self.title = "TIME'S ARROW edit " + @timeline.name + " timeline"
    # search 
    # change this to ajax search
    keywords = params[:keywords]
    if !keywords.nil?
      if keywords == ""
        flash[:error] = "Please enter keywords"
      else
        # amazon-ecs
        category = @timeline.category
        s = Search.new(keywords,category)
        s.search_amazon_item_search
        flash[:error] = s.error
        @itemarray = s.results
      end
    end
  end


  def create
    @timeline = Timeline.new(params[:timeline])
    if @timeline.save
      flash[:notice] = 'Timeline was successfully created.'
      redirect_to edit_timeline_path(@timeline) 
    else
      render :action => "new" 
    end
    
  end


  def update
    @timeline = Timeline.find(params[:id])
    
    if @timeline.update_attributes(params[:timeline])
      flash[:notice] = 'Timeline was successfully updated.'
      redirect_to(@timeline) 
    else
      render :action => "edit" 
    end
    
  end


  def destroy
    @timeline = Timeline.find(params[:id])
    @timeline.destroy
    redirect_to(timelines_url) 
  end
  
  # select item from amazon search and save into timeline
  def select_item
    asin = params[:asin]
    # get response from amazon 
    searchitem = get_item_lookup(asin).items[0]
    @item = Item.save_item_from_search(searchitem)
    TimelineItem.save_timeline_item_from_search(@item, params[:id])
    
    redirect_to :action => "edit", :id => params[:id]
    
  end
  
  def featured
    @timelines = Timeline.featured
    self.title = "TIME'S ARROW - Featured Timelines"
  end
  
  def makeone
    self.title = "TIME'S ARROW - Make a timeline"
  end
  
  def filtered
    category = params[:category]
    subcategory = params[:subcategory]
    genre = params[:genre]
    @timelines = Timeline.filtered_cat(category).filtered_subcat(subcategory).filtered_genre(genre)
    @headertitle = "TIME'S ARROW - Book " + subcategory
    @contenttitle = 'Book ' + subcategory
    self.title = @headertitle
  end
  
end
