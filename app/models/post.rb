require 'uri'

class Post < ActiveRecord::Base
	belongs_to :site, :touch => true
	belongs_to :user
	attr_accessible :news_text, :news_source, :multimedia, :title, :username, :created_at, :image, :user_id, :remove_image
	mount_uploader :image, ImageUploader
	validates :title, :news_source, :news_text,  :presence => true
	extend FriendlyId
  	friendly_id :title, :use => :scoped, :scope => :site



	def parse_title(string)
		string = string.downcase
		string = string.tr(' ', '-')
	end

	def parse_url(string)
		if string.include?('http://') || string.include?('https://')
			then
				uri = URI.parse(string)
				domain = PublicSuffix.parse(uri.host)
			else ('http://') + string
				uri = URI.parse(string)
				domain = PublicSuffix.parse(uri.host)
		end
		return domain
	end

	def mostrar_image
		picture_url or multimedia
	end
	
end
