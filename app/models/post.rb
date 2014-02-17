require 'uri'

class Post < ActiveRecord::Base
	belongs_to :site, :touch => true
	belongs_to :user
	attr_accessible :bajada, :fuente, :multimedia, :titulo, :usuario, :created_at, :foto, :user_id, :remove_foto
	mount_uploader :foto, FotoUploader
	validates :titulo, :fuente, :bajada,  :presence => true
	extend FriendlyId
  	friendly_id :titulo, :use => :scoped, :scope => :site



	def parsear_titulo(string)
		string = string.downcase
		string = string.tr(' ', '-')
	end

	def parsear_url(string)
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

	def mostrar_foto
		picture_url or multimedia
	end
	
end
