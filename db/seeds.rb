# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Role.create(:name => 'Admin')
Role.create(:name => 'username')
user = User.create(:email => 'admin@infobae.com', :password => '12345678', :username => 'admin', :name => 'Mr Admin')
user.give_admin
