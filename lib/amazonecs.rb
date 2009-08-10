require 'amazon/ecs'

# amazon-ecs gem integration below 

@@key_id = '1FZFQX4TKGCZNDQ44P02'
@@associate_id = 'timesarrow-20'
@@secretkey = 'OYK5tbGh8oFHfRHIpvmI6Vf7W5KT770ZY+ScTqmY'

# item search
def get_item_search_response(keywords, search_type)
  search_index = get_search_index(search_type)
  res = ecs.item_search(keywords, :response_group => 'Medium', :search_index => search_index)
  return res
end

# item lookup
def get_item_lookup(asin)
  res = ecs.item_lookup(asin, :response_group => 'Medium')
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

def get_search_index(search_type)
  search_index = case search_type
    when "Book" then "Books"
    when "Music" then "Music"
    when "Movie" then "DVD"
    when "Television" then "DVDs"
    when "Multimedia" then "Blended"
    else search_type
  end
  return search_index
end