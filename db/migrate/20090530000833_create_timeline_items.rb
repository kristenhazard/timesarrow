class CreateTimelineItems < ActiveRecord::Migration
  def self.up
    create_table :timeline_items do |t|
      t.integer :timeline_id
      t.integer :item_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :timeline_items
  end
end
