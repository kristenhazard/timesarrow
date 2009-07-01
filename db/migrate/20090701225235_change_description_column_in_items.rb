class ChangeDescriptionColumnInItems < ActiveRecord::Migration
  def self.up
    change_column :items, :description, :text
  end

  def self.down
    change_column :items, :description, :string
  end
end
