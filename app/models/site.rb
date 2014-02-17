class Site < ActiveRecord::Base
  	extend FriendlyId
  	friendly_id :nombre, use: :slugged
  	attr_accessible :nombre, :user_id
  	validates :nombre,  :presence => true
  	has_many :posts, :dependent => :destroy
  	has_one :user
end
