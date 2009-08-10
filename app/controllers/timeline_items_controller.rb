class TimelineItemsController < ApplicationController
  before_filter :authorize, :except => [:popup, :work_it]
  in_place_edit_for :timeline_item, :position_desc
  
  # GET /timeline_items
  # GET /timeline_items.xml
  def index
    @timeline_items = TimelineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timeline_items }
    end
  end

  # GET /timeline_items/1
  # GET /timeline_items/1.xml
  def show
    @timeline_item = TimelineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timeline_item }
    end
  end

  # GET /timeline_items/new
  # GET /timeline_items/new.xml
  def new
    @timeline_item = TimelineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timeline_item }
    end
  end

  # GET /timeline_items/1/edit
  def edit
    @timeline_item = TimelineItem.find(params[:id])
  end

  # POST /timeline_items
  # POST /timeline_items.xml
  def create
    @timeline_item = TimelineItem.new(params[:timeline_item])

    respond_to do |format|
      if @timeline_item.save
        flash[:notice] = 'TimelineItem was successfully created.'
        format.html { redirect_to(@timeline_item) }
        format.xml  { render :xml => @timeline_item, :status => :created, :location => @timeline_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timeline_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /timeline_items/1
  # PUT /timeline_items/1.xml
  def update
    @timeline_item = TimelineItem.find(params[:id])

    respond_to do |format|
      if @timeline_item.update_attributes(params[:timeline_item])
        flash[:notice] = 'TimelineItem was successfully updated.'
        format.html { redirect_to(@timeline_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timeline_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /timeline_items/1
  # DELETE /timeline_items/1.xml
  def destroy
    @timeline_item = TimelineItem.find(params[:id])
    @timeline_item.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
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
    logger.info max
    #min = @timeline.timeline_items.min
    @timeline.timeline_items.each do |ti|
      min = ti.position
      logger.info min
      ti.position = max + 1 - min
      ti.save!
    end
    redirect_to :controller => "timelines", :action => "edit", :id => params[:id]
  end

end
