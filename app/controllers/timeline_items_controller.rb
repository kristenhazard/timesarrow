class TimelineItemsController < ApplicationController
  # GET /timeline_items
  # GET /timeline_items.xml
  def index
    @timeline_items = TimelineItem.all(:order => 'timeline_id')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timeline_items }
    end
  end

  # GET /timeline_items/1
  # GET /timeline_items/1.xml
  def show
    @timeline_item = TimelineItem.find(params[:id])
    #@item = @timeline_item.item

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
      format.html { redirect_to(timeline_items_url) }
      format.xml  { head :ok }
    end
  end
end
