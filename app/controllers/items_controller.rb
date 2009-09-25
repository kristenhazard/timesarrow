class ItemsController < ApplicationController
  
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @timelines = @item.timelines #show all timelines item belongs to
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
    
    keywords = params[:keywords]
    if !keywords.nil?
      if keywords == ""
        flash[:error] = "Please enter keywords"
      else
        # amazon-ecs
        item_type = @item.itemtype
        res = get_item_search_response(keywords, item_type)
        @error = res.error
        flash[:error] = @error
        @itemarray = res.items
      end
    end
  end


  def create
    @item = Item.new(params[:item])
    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to(@item) 
    else
      render :action => "new" 
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      flash[:notice] = 'Item was successfully updated.'
      redirect_to(@item) 
    else
      render :action => "edit" 
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to(items_url) 
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
