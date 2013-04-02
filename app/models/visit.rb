class Visit < ActiveRecord::Base
  belongs_to :short_url
  belongs_to :user

  attr_accessible :visit_time, :user_id, :short_url_id

end