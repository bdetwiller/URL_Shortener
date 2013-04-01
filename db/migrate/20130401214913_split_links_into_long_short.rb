class SplitLinksIntoLongShort < ActiveRecord::Migration
  def up
    drop_table :links

    create_table :long_url do |t|
      t.string :url
    end

    create_table :short_url do |t|
      t.string :url
      t.integer :long_id
      t.integer :user_id
    end
  end

  def down
    create_table :links do |t|
      t.string   :long_url
      t.string   :short_url
      t.datetime :created_at, :null => false
      t.datetime :updated_at, :null => false
      t.integer  :user_id
    end
  end
end
