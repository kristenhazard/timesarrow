class SearchController < ApplicationController
  def show
    # I want to remove search from timeline controller edit action into here
  end

  def select_item
    asin = params[:asin]
    timeline_id = params[:id]
    # get response from amazon 
    
    item = Item.save_item_from_search(asin)
    TimelineItem.save_timeline_item_from_search(item, timeline_id)
    
    redirect_to :controller => "timelines", :action => "edit", :id => timeline_id
  end

end
