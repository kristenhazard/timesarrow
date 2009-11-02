class AddPositionTypeToTimelineItems < ActiveRecord::Migration
  def self.up
    add_column :timeline_items, :position_type, :int, :default => 1
  end

  def self.down
    remove_column :timeline_items, :position_type
  end
end
