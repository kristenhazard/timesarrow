class AddIsbnSwatchimageurlLargeimageurlToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :isbn, :string
    add_column :items, :swatchimageurl, :string
    add_column :items, :largeimageurl, :string
  end

  def self.down
    remove_column :items, :largeimageurl
    remove_column :items, :swatchimageurl
    remove_column :items, :isbn
  end
end
