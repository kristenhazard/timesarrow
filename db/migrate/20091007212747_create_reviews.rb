class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.integer :item_id
      t.integer :user_id
      t.text :content
      t.timestamps
    end
  end
  
  def self.down
    drop_table :reviews
  end
end
