class TimelineItemsController < ApplicationController
  before_filter :authorize, :except => [:popup, :work_it]
  in_place_edit_for :timeline_item, :position_desc
  
  def index
    #@timeline_items = TimelineItem.all
    @timeline_items = TimelineItem.find(:all, :include => [ :item, :timeline ], :order => 'items.title')
  end

  def show
    @timeline_item = TimelineItem.find(params[:id])
  end

  def new
    @timeline_item = TimelineItem.new
  end

  def edit
    @timeline_item = TimelineItem.find(params[:id])
  end

  def create
    @timeline_item = TimelineItem.new(params[:timeline_item])

    if @timeline_item.save
      flash[:notice] = 'TimelineItem was successfully created.'
      redirect_to(@timeline_item) 
    else
      render :action => "new" 
    end
    
  end

  def update
    @timeline_item = TimelineItem.find(params[:id])
    
    if @timeline_item.update_attributes(params[:timeline_item])
      flash[:notice] = 'TimelineItem was successfully updated.'
      redirect_to(@timeline_item) 
    else
      render :action => "edit" 
    end
    
  end

  def destroy
    @timeline_item = TimelineItem.find(params[:id])
    @timeline_item.destroy
    
    redirect_to :back
  end
  
  def popup
    @timeline_item = TimelineItem.find(params[:id])
    render :layout => false
  end
  
  def work_it
    @timeline_item = TimelineItem.find(params[:id])
    render :partial => 'shared/item_work'
  end
  
  def sort
    params[:dtimeline].each_with_index do |id, index|
      TimelineItem.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def re_sort
    # loop through timeline items and apply resort algorithm
    @timeline = Timeline.find(params[:id])
    max = @timeline.timeline_items.count
    @timeline.timeline_items.each do |ti|
      min = ti.position
      ti.position = max + 1 - min
      ti.save!
    end
    redirect_to :controller => "timelines", :action => "edit", :id => params[:id]
  end

end
