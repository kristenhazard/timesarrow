class CreateItemAuthors < ActiveRecord::Migration
  def self.up
    create_table :item_authors do |t|
      t.integer :item_id
      t.integer :author_id

      t.timestamps
    end
  end

  def self.down
    drop_table :item_authors
  end
end
