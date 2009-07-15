class ChangeDescriptionLimit < ActiveRecord::Migration
  def self.up
    change_column :items, :description, :text, :limit => 2000
  end

  def self.down
    change_column :items, :description, :text, :limit => 255
  end
end
