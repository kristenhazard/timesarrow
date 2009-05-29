require 'amazon/ecs'

# amazon-ecs gem integration below 

@@key_id = '1FZFQX4TKGCZNDQ44P02'
@@associate_id = 'timesarrow-20'

# item search
def get_item_search_response(keywords)
  res = ecs.item_search(keywords, :response_group => 'Medium')
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
  end  
  return Amazon::Ecs  
end