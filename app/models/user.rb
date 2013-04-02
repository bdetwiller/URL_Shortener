class User < ActiveRecord::Base
  has_many :short_urls
  has_many :visits
  has_many :short_urls, :through => :visits

  attr_accessible :screen_name, :e_mail

  def submitted_links
    links = ShortUrl.where(:user_id => self.id)
    puts "User has submitted the following #{link.count} link(s):"
    puts links
  end
end