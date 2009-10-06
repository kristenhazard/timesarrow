class CreateItemStatuses < ActiveRecord::Migration
  def self.up
    create_table :item_statuses do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :status_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :item_statuses
  end
end
