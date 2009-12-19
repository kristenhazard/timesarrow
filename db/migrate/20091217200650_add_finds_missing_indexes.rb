class AddFindsMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :items, :category_id
    add_index :items, :title
    add_index :items, :author
    add_index :item_statuses, :status_id
    add_index :item_statuses, :user_id
    add_index :item_statuses, :item_id
    add_index :statuses, :category_id
    add_index :reviews, :user_id
    add_index :reviews, :item_id
  end
  
  def self.down
    remove_index :items, :category_id
    remove_index :items, :title
    remove_index :items, :author
    remove_index :item_statuses, :status_id
    remove_index :item_statuses, :user_id
    remove_index :item_statuses, :item_id
    remove_index :statuses, :category_id
    remove_index :reviews, :user_id
    remove_index :reviews, :item_id
  end

end
