class TimelinesController < ApplicationController
  
  before_filter :require_logged_in, :except => [:index, :show, :featured, :filtered ]
  before_filter :store_location #in case user is not logged in I want to store this location for them to go back to
  
  def index
    @timelines = Timeline.search(params[:search], params[:page])
    self.title = "TIME'S ARROW - All Timelines"
  end


  def show
    @timeline = Timeline.find(params[:id], :include => [ :items, :timeline_items ])
    item_id = params[:item_id]
    
    if item_id 
      @item = Item.find(item_id)
      ti = @timeline.timeline_items.find_by_item_id(item_id)
      @carousel_position = ti.position - 1 - @timeline.timeline_items.count_of_finalists(ti.position)
      @timeline_items_finalists = @timeline.timeline_items.finalists_by_year(ti.position_desc)
    else
      ti = @timeline.timeline_items[0]
      @item = ti.item
      @carousel_position = ti.position - 1
      @timeline_items_finalists = @timeline.timeline_items.finalists_by_year(ti.position_desc)
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
    
    rescue NoMethodError
      logger.error("Attempt to access invalide item_id for timeline")
      flash[:notice] = "Please add books to your timeline"
      redirect_to edit_timeline_path(@timeline) 
  end


  def new
    @timeline = Timeline.new
    self.title = "TIME'S ARROW - create new timeline"
  end


  def edit
    @timeline = Timeline.find(params[:id])
    if @timeline.current_user_is_owner? or admin?
      self.title = "TIME'S ARROW edit " + @timeline.name + " timeline"
      @featured_string_value = @timeline.featured.to_s
    else
      flash[:notice] = "You can only edit timelines you have created."
      redirect_to(@timeline)
    end
  end


  def create
    @timeline = Timeline.new(params[:timeline])
    @timeline.user_id = current_user.id
    unless admin?
      @timeline.category = "Book"
      @timeline.featured = 0
    end
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
    flash[:notice] = 'Timeline was successfully deleted.'
    redirect_to(timelines_url) 
  end

  
  def featured
    @timelines = Timeline.featured
    self.title = "TIME'S ARROW - Featured Timelines"
  end
  
  
  def filtered
    category = params[:category]
    subcategory = params[:subcategory]
    genre = params[:genre]
    @timelines = Timeline.filtered_cat(category).filtered_subcat(subcategory).filtered_genre(genre).all(:order => 'name')
    
    if genre.nil? 
      genre = ""
    end
    @contenttitle = 'Book ' + subcategory + " " + genre
    self.title = "TIME'S ARROW - Book " + subcategory + " " + genre
    
  end
  
  # to be removed once I actually allow users to make a timeline, 
  #this is just a placeholder to check if users actually click this link
  def makeone
    self.title = "TIME'S ARROW - Make a timeline"
  end
  
end
