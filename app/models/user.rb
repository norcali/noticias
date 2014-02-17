class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :roles
  belongs_to :site, :touch => true
  has_many :posts
  mount_uploader :avatar, ImageUploader
  extend FriendlyId
    friendly_id :username

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :username, :role_ids, :descripcion, :avatar, :name, :handle, :site_id
  # attr_accessible :title, :body
  validates :email, :username, :name, :presence => true


  before_save :setup_role

  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end

  # Default role is "Registered"
  def setup_role
    if self.role_ids.empty?
      self.role_ids = [2]
    end
  end

  def give_admin
    self.role_ids = [1]
  end

  require 'open-uri'
  require 'net/http'

  def tiene_blog(string)
    dir = "http://opinion.infobae.com/#{parse_name(string)}/"
    url = URI.parse(dir)
    req = Net::HTTP.new(url.host, url.port)
    res = req.request_head(url.path).code == "200"
  end

  def parse_name(name)
    bak = name.downcase
    bak = bak.tr(' ', '-')
  end

  def admin?
    self.role_ids == [1]
  end

end
