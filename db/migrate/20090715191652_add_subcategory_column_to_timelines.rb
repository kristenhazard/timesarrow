class AddSubcategoryColumnToTimelines < ActiveRecord::Migration
  def self.up
    add_column :timelines, :subcategory, :string
    add_column :timelines, :featured, :int
  end

  def self.down
    remove_column :timelines, :subcategory
    remove_column :timelines, :featured
  end
end
