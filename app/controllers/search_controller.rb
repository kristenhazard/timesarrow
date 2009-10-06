class SearchController < ApplicationController
  def search
    # I want to remove search from timeline controller edit action into here
    keywords = params[:keywords]
    category = params[:category]
    @timelineid = params[:timelineid]
    @itemid = params[:itemid]
    if !keywords.nil?
      if keywords == ""
        flash[:error] = "Please enter keywords"
      else
        # amazon-ecs
        s = Search.new(keywords,category)
        s.search_amazon_item_search
        flash[:error] = s.error
        @itemarray = s.results
      end
    end
    render :partial => 'shared/search_results', :locals => { :itemarray => @itemarray, 
                                                             :timelineid => @timelineid,
                                                             :itemid => @itemid }
  end

  def select_item
    asin = params[:asin]
    timelineid = params[:timelineid]
    itemid = params[:itemid]
    if timelineid == ""
      searchitem = get_item_lookup(asin).items[0]
      item = Item.find(itemid)
      # set item attributes based on response from amazon
      Item.update_item_from_search(searchitem,item)
      redirect_to :controller => "items", :action => "edit", :id => itemid
    else
      item = Item.save_item_from_search(asin)
      TimelineItem.save_timeline_item_from_search(item, timelineid)
      redirect_to :controller => "timelines", :action => "edit", :id => timelineid
    end
  end

end
