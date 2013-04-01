class AddUrlTable < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :long_url
      t.string :short_url
      t.timestamps
    end

    create_table :users do |t|
      t.string :e_mail
      t.string :screen_name
      t.timestamps
    end

    create_table :visits do |t|
      t.time :visit_time
      t.string :user_id
      t.string :link_id
      t.timestamps
    end
  end
end
