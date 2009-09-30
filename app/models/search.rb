require 'amazonecs'

class Search
  attr_reader :keywords, :search_type, :error, :results
  
  def initialize(keywords, search_type)
    @keywords = keywords
    @search_type = search_type
    @error = ""
    @results = []
  end
  
  def get_item_search_response
    search_index = get_search_index(search_type)
    res = ecs.item_search(keywords, :response_group => 'Medium', :search_index => search_index)
    return res
  end
  
  def get_search_index(search_type)
    search_index = case search_type
      when "Book" then "Books"
      when "Music" then "Music"
      when "Movie" then "DVD"
      when "Television" then "DVDs"
      when "Multimedia" then "Blended"
      else search_type
    end
  end

  def search_amazon_item_search
    search_index = get_search_index(search_type)
    res = ecs.item_search(@keywords, :response_group => 'Medium', :search_index => search_index)
    res.is_valid_request?
    @error = res.error
    @results = res.items
  end


end