class AddUniqueCols < ActiveRecord::Migration
  def change
    add_index :links, :long_url, :unique => true
  end
end
