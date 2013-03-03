class Link < ActiveRecord::Base
  belongs_to :url

  scope :random , order: "RANDOM()"
  validates :address, :format => URI::regexp(%w(http https))

end
