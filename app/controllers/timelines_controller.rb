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
    @item = @timeline.timeline_items[0].item
    self.title = "TIME'S ARROW: " + @timeline.name + " timeline"
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
  end
  
  
  def filtered
    category = params[:category]
    subcategory = params[:subcategory]
    genre = params[:genre]
    @timelines = Timeline.filtered_cat(category).filtered_subcat(subcategory).filtered_genre(genre).all(:order => 'genre')
    @headertitle = "TIME'S ARROW - Book " + subcategory
    @contenttitle = 'Book ' + subcategory
    self.title = @headertitle
  end
  
  # to be removed once I actually allow users to make a timeline, 
  #this is just a placeholder to check if users actually click this link
  def makeone
    self.title = "TIME'S ARROW - Make a timeline"
  end
  
end
