# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
20.times do |n|
  email = "user#{n+1}@gmail.com"
  password  = "password"
  User.create_with(password: password, password_confirmation: password).find_or_create_by(email: email)
end
