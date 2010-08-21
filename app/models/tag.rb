class Tag
  
  attr_accessor :name, :count, :weight
  
  def initialize(name, count, weight)
    @name = name
    @count = count
    @weight = weight
  end
  
  def tags
    category = "Book"
    subcategory = "Awards"
    genre = "Fiction"
    @timelines = Timeline.filtered_cat(category).filtered_subcat(subcategory).filtered_genre(genre).all(:order => 'name')
    # author cloud
    @winners = @timelines.map { |t| t.winners }.flatten!
    @authors = @winners.map {|i| Item.find(i.item_id).author}
    @ac = @authors.inject(Hash.new(0)) {|h,i| h[i] += 1; h }.sort
  end
end

class TagList
  def initialize
    @tags = Array.new
    t1 = Tag.new('A. B. Guthrie Jr.', 1, 1)
    t2 = Tag.new('Bernard Malamud', 2, 2)
    t3 = Tag.new('Philip Roth', 7, 7)
    @tags.push(t1)
    @tags.push(t2)
    @tags.push(t3)
  end
end