class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.string :type
      t.string :author
      t.string :description
      t.string :asin
      t.string :detailpageurl
      t.string :smallimageurl
      t.string :mediumimageurl
      t.date :publicationdate

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
