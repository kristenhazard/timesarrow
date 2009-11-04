class ChangeDescriptionInTimeline < ActiveRecord::Migration
  def self.up
    change_column :timelines, :description, :text
  end

  def self.down
    change_column :timelines, :description, :string
  end
end
