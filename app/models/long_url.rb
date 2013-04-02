class LongUrl < ActiveRecord::Base
  has_many :short_urls
  attr_accessible :url

  def self.find(long_url)
    LongUrl.where(:url => long_url)
  end

end