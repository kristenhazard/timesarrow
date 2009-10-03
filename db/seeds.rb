["Book", "Music", "Movie", "Television", "Multimedia"].each do |c|
  Category.find_or_create_by_name(c)
end