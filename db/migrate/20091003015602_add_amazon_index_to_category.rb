class AddAmazonIndexToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :amazon_index, :string
    add_column :categories, :amazon_product_group, :string
  end

  def self.down
    remove_column :categories, :amazon_index
    remove_column :categories, :amazon_product_group
  end
end
