class Url < ActiveRecord::Base
	has_many :links
	validates :access_token, :uniqueness => true
	accepts_nested_attributes_for :links, :allow_destroy => true, :reject_if => :all_blank
	validate :links_presence?


	def access_token_set
		token = generate
		unless Url.exists?( :access_token => token)
			self.access_token = token
		else
			access_token_set
		end
	end

	def generate
		require 'securerandom'
		s = SecureRandom.urlsafe_base64(6)
	end

	private
	def links_presence?
		errors.add(:links, "can't be blank") if links.blank?
	end
end
