class TimelinesController < ApplicationController
  require 'amazonecs'
  
  before_filter :require_admin, :except => [:index, :show, :featured, :filtered, :makeone]
  
  def index
    @timelines = Timeline.all(:include => [ :items, :timeline_items ], 
                              :order => 'category, subcategory, genre, featured desc')
    self.title = "TIME'S ARROW - All Timelines"
    store_location #in case user is not logged in I want to store this location for them to go back to
  end


  def show
    @timeline = Timeline.find(params[:id], :include => [ :items, :timeline_items ])
    item_id = params[:item_id]
    if item_id 
      @item = Item.find(item_id)
      @timeline_item = TimelineItem.find_by_timeline_id_and_item_id(@timeline.id,item_id)
      @carousel_position = @timeline_item.position - 1
    else
      @item = @timeline.timeline_items[0].item
      @carousel_position = @timeline.timeline_items[0].position - 1
    end
    
    # duplicate code alert, need to get rid of this, code is also in items_controller, work_it
    if logged_in?
      userid = current_user.id
      @review = @item.reviews.find_by_user_id(userid)
      if @review.nil?
        @item.reviews.build(:user_id => userid)
      end
    end
    
    self.title = "TIME'S ARROW: " + @timeline.name + " timeline"
    store_location #in case user is not logged in I want to store this location for them to go back to
  end


  def new
    @timeline = Timeline.new
    self.title = "TIME'S ARROW - create new timeline"
  end


  def edit
    @timeline = Timeline.find(params[:id])
    self.title = "TIME'S ARROW edit " + @timeline.name + " timeline"
    # change this to ajax search
    
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

  
  def featured
    @timelines = Timeline.featured
    self.title = "TIME'S ARROW - Featured Timelines"
    store_location #in case user is not logged in I want to store this location for them to go back to
  end
  
  
  def filtered
    category = params[:category]
    subcategory = params[:subcategory]
    genre = params[:genre]
    @timelines = Timeline.filtered_cat(category).filtered_subcat(subcategory).filtered_genre(genre).all(:order => 'genre')
    @headertitle = "TIME'S ARROW - Book " + subcategory
    @contenttitle = 'Book ' + subcategory
    self.title = @headertitle
    store_location #in case user is not logged in I want to store this location for them to go back to
  end
  
  # to be removed once I actually allow users to make a timeline, 
  #this is just a placeholder to check if users actually click this link
  def makeone
    self.title = "TIME'S ARROW - Make a timeline"
    store_location #in case user is not logged in I want to store this location for them to go back to
  end
  
end
