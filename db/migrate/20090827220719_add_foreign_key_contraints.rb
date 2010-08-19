class AddForeignKeyContraints < ActiveRecord::Migration
  def self.up
    # execute "ALTER TABLE timeline_items ADD CONSTRAINT fk_timeline_id FOREIGN KEY (timeline_id) REFERENCES timelines (id) ON DELETE CASCADE" 
    # execute "ALTER TABLE timeline_items ADD CONSTRAINT fk_item_id FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE CASCADE"
  
  end

  def self.down
    execute "ALTER TABLE timeline_items DROP FOREIGN KEY fk_timeline_id"
    execute "ALTER TABLE timeline_items DROP FOREIGN KEY fk_item_id"
  end
end