class Search
  attr_reader :keywords, :search_type
  
  def initialize(keywords, search_type)
    @keywords = keywords
    @search_type = search_type
    @results = []
    @error = ""
  end
  
  def search_amazon_item_search
    #Amazon::Ecs.options = { :aWS_access_key_id => @@key_id, :associate_tag => @@associate_id, :aWS_secret_key => @@secretkey }
    search_index = get_search_index(search_type)
    res = ecs.item_search(@keywords, :response_group => 'Medium', :search_index => search_index)
    res.is_valid_request?
    @error = res.error
    @results = res.items
  end
  
  def get_item_search_response
    search_index = get_search_index(search_type)
    res = ecs.item_search(keywords, :response_group => 'Medium', :search_index => search_index)
    return res
  end
  
  # configure and return an Ecs object
  def ecs
    Amazon::Ecs.configure do |options|
      options[:aWS_access_key_id] = @@key_id
      options[:associate_tag] = @@associate_id
      options[:aWS_secret_key] = @@secretkey
    end  
    return Amazon::Ecs  
  end
  
  @@key_id = '1FZFQX4TKGCZNDQ44P02'
  @@associate_id = 'timesarrow-20'
  @@secretkey = 'OYK5tbGh8oFHfRHIpvmI6Vf7W5KT770ZY+ScTqmY'
  
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
  
end