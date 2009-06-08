class AddPositionDescToTimelineItem < ActiveRecord::Migration
  def self.up
    add_column :timeline_items, :position_desc, :string
  end

  def self.down
    remove_column :timeline_items, :position_desc
  end
end
