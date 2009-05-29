class SearchController < ApplicationController
  require 'amazonecs'
  
  def index
    keywords = params[:keywords]
    if request.post?
      if keywords == ""
        flash[:error] = "Please enter keywords"
      else
        # amazon-ecs
        res = get_item_search_response(keywords)
        @error = res.error
        flash[:error] = @error
        @itemarray = res.items
        
      end
      
      respond_to do |format|
          format.html
          format.xml
      end
    end
  end

end
