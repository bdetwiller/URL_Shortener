class User < ActiveRecord::Base
  has_many :links
  has_many :visits
  has_many :links, :through => :visits

  def User.create_user(screen_name, email)
    user.create(:screen_name => screen_name, :email => email)
  end

  def submitted_links
    links = Short_url.where(:user_id => self.id)
    puts "User has submitted the following #{links.count} link(s):"
    puts links
  end
end