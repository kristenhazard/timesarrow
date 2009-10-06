["Book", "Music", "Movie", "Television", "Multimedia"].each do |c|
  Category.find_or_create_by_name(c)
end

["Read", "Abandoned", "Plan To Read", "Reading Now", "Not Interested"]. each do |s|
  Status.find_or_create_by_description(:description => s, :category_id => Category.find_by_name("Book").id)
end