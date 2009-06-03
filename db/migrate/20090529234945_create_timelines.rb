class CreateTimelines < ActiveRecord::Migration
  def self.up
    create_table :timelines do |t|
      t.string :name
      t.string :description
      t.string :imageurl

      t.timestamps
    end
  end

  def self.down
    drop_table :timelines
  end
end
