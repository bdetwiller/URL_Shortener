class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :short_urls, :through => :taggings

  attr_accessible :name

  ALLOWED_TAGS = ["Cats", "Dogs", "Kittens", "Puppies"]

  def self.add(initial_cols)
    unless ALLOWED_TAGS.include?(initial_cols[:name])
      raise 'Forbidden tag'
    end
    Tag.create(initial_cols)
  end
end