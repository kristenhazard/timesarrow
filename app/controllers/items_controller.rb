class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    
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
      end
    end
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(@item) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  
  # search results selected and saved into item
  def select_item
    asin = params[:asin]
    # get response from amazon 
    res = get_item_lookup(asin)
    item = res.items[0]
    
    # set item attributes based on response from amazon
    @item = Item.find(params[:id])
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
    
    # save item
    @item.asin = item.get("asin")
    @item.detailpageurl = item.get("detailpageurl")
    @item.smallimageurl = item.get("smallimage/url")
    @item.mediumimageurl = item.get("mediumimage/url")
    @item.publicationdate = item.get("publicationdate")
    @item.save
    
    redirect_to :action => "edit", :id => params[:id]
    
  end
end
