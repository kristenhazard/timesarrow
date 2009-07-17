class AddGenreToTimelines < ActiveRecord::Migration
  def self.up
    add_column :timelines, :genre, :string
  end

  def self.down
    remove_column :timelines, :genre
  end
end
