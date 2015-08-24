# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless User.exists?(email: "admin@vroom.com")
  User.create!(email: "admin@vroom.com", password: "password", admin: true)
end

unless User.exists?(email: "user@vroom.com")
  User.create!(email: "user@vroom.com", password: "password")
end

["John Smith", "Joe Doe"].each do |name|
  unless Person.exists?(name: name)
    Person.create!(name: name, title: "Software Engineer")
  end
end