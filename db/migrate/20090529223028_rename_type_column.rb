class RenameTypeColumn < ActiveRecord::Migration
  def self.up
    rename_column :items, :type, :itemtype
  end

  def self.down
    rename_column :items, :itemtype, :type
  end
end
