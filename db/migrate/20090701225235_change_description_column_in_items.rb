class ChangeDescriptionColumnInItems < ActiveRecord::Migration
  def self.up
    change_column :items, :description, :text, :limit => 1000
  end

  def self.down
    change_column :items, :description, :string
  end
end
