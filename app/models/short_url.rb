class ShortUrl < ActiveRecord::Base
  belongs_to :user
  belongs_to :long_url
  has_many :visits
  has_many :tags, :through => :taggings
  attr_accessible :url, :user_id, :long_id

  def self.add(long_url, screen_name)
    user_id = ShortUrl.name_to_id(screen_name)
    link = LongUrl.where(:url => long_url)
    if link == []
      long_url_id = LongUrl.create(:url => long_url).id
    else
      long_url_id = link.first.id
      if ShortUrl.where(:long_id => long_url_id, :user_id => user_id)
        raise 'You have already created a link for this URL.'
      end
    end
    short_url = "http://lande.com/#{SecureRandom.urlsafe_base64}"
    ShortUrl.create(:url => short_url, :long_id => long_url_id, :user_id => user_id)
  end

  def self.launch(short_url, screen_name)
    sql_query = ShortUrl.where(:url => short_url).first
    user_id = name_to_id(screen_name)
    if sql_query
      long = LongUrl.where(:id => sql_query.long_id).first
      Launchy.open(long.url)
      Visit.create(:user_id => user_id, :short_url_id => sql_query.id)
    else
      raise 'That short url is not in the database.'
    end
  end

  def print_stats
    visitors = Visit.where(:short_url_id => self.id)
    current_time = Time.now - 600
    past_ten_min = Visit.where("created_at >= ?", current_time)

    puts "Number of Visitors : #{visitors.count}"
    puts "Number of Unique Visitors : #{visitors.uniq.count}"
    puts "Visitors in past ten minutes"
    puts past_ten_min
  end

  def self.name_to_id(screen_name)
    User.where(:screen_name => screen_name).first.id
  end

  def self.find(long_url, screen_name)
    user_id = ShortUrl.name_to_id(screen_name)
    long_id = LongUrl.where(:url => long_url).first.id
    ShortUrl.where(:long_id => long_id, :user_id => user_id)
  end

end