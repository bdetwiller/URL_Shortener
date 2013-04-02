class AddingCommentsAndTags < ActiveRecord::Migration
  def change
    rename_column :visits, :link_id, :short_url_id
    create_table :comments do |t|
      t.integer :user_id
      t.integer :short_url_id
      t.text :body

      t.timestamp
    end
    create_table :tags do |t|
      t.string :name

      t.timestamp
    end
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :short_url_id

      t.timestamp
    end
  end
end
