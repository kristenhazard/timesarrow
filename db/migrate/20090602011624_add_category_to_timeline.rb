class AddCategoryToTimeline < ActiveRecord::Migration
  def self.up
    add_column :timelines, :category, :string
  end

  def self.down
    remove_column :timelines, :category
  end
end
