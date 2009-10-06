class SearchController < ApplicationController
  def search
    # I want to remove search from timeline controller edit action into here
    keywords = params[:keywords]
    category = params[:category]
    @timelineid = params[:timelineid]
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
    render :partial => 'shared/search_results', :locals => { :itemarray => @itemarray, :timelineid => @timelineid }
  end

  def select_item
    asin = params[:asin]
    timelineid = params[:timelineid]
    # get response from amazon 
    
    item = Item.save_item_from_search(asin)
    TimelineItem.save_timeline_item_from_search(item, timelineid)
    
    redirect_to :controller => "timelines", :action => "edit", :id => timelineid
  end

end
