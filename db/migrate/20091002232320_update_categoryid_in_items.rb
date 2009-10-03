class UpdateCategoryidInItems < ActiveRecord::Migration
  def self.up
    bookitems = Item.find_all_by_itemtype('Book')
    bookitems.each do |bi|
      bi.category_id = Category.find_by_name('Book').id
      bi.save
    end
    
    ebookitems = Item.find_all_by_itemtype('eBooks')
    ebookitems.each do |ebi|
      ebi.category_id = Category.find_by_name('Book').id
      ebi.save
    end
    
    dvditems = Item.find_all_by_itemtype('DVD')
    dvditems.each do |dvd|
      dvd.category_id = Category.find_by_name('Movie').id
      dvd.save
    end
  end

  def self.down
    Item.all.each do |i|
      i.category_id = nil
      i.save
    end
  end
end
