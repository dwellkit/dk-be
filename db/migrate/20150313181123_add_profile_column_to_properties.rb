class AddProfileColumnToProperties < ActiveRecord::Migration
  def self.up
    add_attachment :properties, :profile
  end

  def self.down
    remove_attachment :properties, :profile
  end
end
