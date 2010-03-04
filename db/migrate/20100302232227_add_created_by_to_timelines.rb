class AddCreatedByToTimelines < ActiveRecord::Migration
  def self.up
    add_column :timelines, :user_id, :integer, :default => 2, :null => false 
    execute "ALTER TABLE timelines ADD CONSTRAINT fk_timeline_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE" 
    add_index :timelines, :user_id
  end

  def self.down
    remove_column :timelines, :user_id
    execute "ALTER TABLE timelines DROP FOREIGN KEY fk_timeline_user_id"  
    remove_index :timelines, :user_id
  end
end
