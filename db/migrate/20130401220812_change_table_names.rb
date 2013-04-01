class ChangeTableNames < ActiveRecord::Migration
  def change
    rename_table :short_url, :short_urls
    rename_table :long_url, :long_urls
  end
end
