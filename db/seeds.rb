# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
UserToProject.destroy_all

300.times do |n|
  name  = Faker::Name.name.split(' ')
  first_name = name[0]
  last_name = name[1]
  username = "user-#{n+1}"
  email = "user-#{n+1}@connextor.co"
  password = "foobar"
  User.create!(username:  username,
               email: email,
               first_name: first_name,
               last_name: last_name,
               password:              password,
               password_confirmation: password)
end

ProjectUserClass.create(name: "Ownership")
ProjectUserClass.create(name: "Core Memebership")
ProjectUserClass.create(name: "Contribution")
ProjectUserClass.create(name: "Follow")
ProjectUserClass.create(name: "Like")

