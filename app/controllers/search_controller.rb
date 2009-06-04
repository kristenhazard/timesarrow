class SearchController < ApplicationController
  require 'amazonecs'
  
  def index
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
  
  def select
    asin = params[:asin]
    res = get_item_lookup(asin)
    item = res.items[0]
    
    @item = Item.new
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
  
    
    @item.asin = item.get("asin")
    @item.detailpageurl = item.get("detailpageurl")
    @item.smallimageurl = item.get("smallimage/url")
    @item.mediumimageurl = item.get("mediumimage/url")
    @item.publicationdate = item.get("publicationdate")
    @item.save
    
    #redirect_to :controller => "items", :action => "index"
    redirect_to :controller => "items", :action => "show", :id => @item.id
    
  end
  
  def search_amazon
    
    keywords = params[:keywords]
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
