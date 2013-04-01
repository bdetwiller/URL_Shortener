class Short_url < ActiveRecord::Base
  belongs_to :user
  belongs_to :long_url
  has_many :visits
  attr_accessible :url, :user_id, :long_id

  def self.add(long_url, screen_name)
    user_id = name_to_id(screen_name)
    link = Long_url.where(:url => long_url)
    if link == []
      long_url_id = Long_url.create(:url => long_url).id
    else
      long_url_id = link.first.id
      if Short_url.where(:long_id => long_url_id, :user_id => user_id)
        raise 'You have already created a link for this URL.'
      end
    end
    short_url = "http://lande.com/#{SecureRandom.urlsafe_base64}"
    Short_url.create(:url => short_url, :long_id => long_url_id, :user_id => user_id)
  end

  def self.launch(short_url, screen_name)
    sql_query = Short_url.where(:url => short_url).first
    user_id = name_to_id(screen_name).first.id
    if sql_query
      long = Long_url.where(:id => sql_query.long_id).first
      Launchy.open(long.url)
      Visit.create(:user_id => user_id, link_id => sql_query.id)
    else
      raise 'That short url is not in the database.'
    end
  end

  def print_stats
    visitors = Visit.where(:link_id => self.id)
    num_visitors = visitors.count
    unique_visitors = visitors.uniq.count
    current_time = (Time.now - 600).to_s[0..-7]
    past_ten_min = Visit.where("created_at >= #{current_time}")
  end

  def name_to_id (screen_name)
    User.where(:screen_name => screen_name).first.id
  end

  def self.find(long_url)
    Link.where(:long_url => long_url)
  end

end