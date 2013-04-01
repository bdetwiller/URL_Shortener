class Long_url < ActiveRecord::Base
  has_many :short_urls
  attr_accessible :url

  def self.find(long_url)
    Link.where(:url => long_url)
  end

end