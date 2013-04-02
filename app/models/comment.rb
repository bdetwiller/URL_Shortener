class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :short_url

  attr_accessible :body, :user_id, :short_url_id
end