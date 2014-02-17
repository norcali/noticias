class Site < ActiveRecord::Base
  	extend FriendlyId
  	friendly_id :name, use: :slugged
  	attr_accessible :name, :user_id
  	validates :name,  :presence => true
  	has_many :posts, :dependent => :destroy
  	has_one :user
end
