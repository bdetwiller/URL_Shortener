class AddForeignKeys < ActiveRecord::Migration
  def change
    add_column :links, :user_id, :integer
    change_column :visits, :user_id, :integer
    change_column :visits, :link_id, :integer
  end
end
