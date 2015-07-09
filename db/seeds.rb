# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Campus.create!(city: "Durham", state: "NC")

Curriculum.create!(name: "Rails Engineering", nickname: "Rails")
Curriculum.create!(name: "Front End Engineering", nickname: "Front End")
Curriculum.create!(name: "Python Engineering", nickname: "Python")
Curriculum.create!(name: "Staff", nickname: "Staff")


User.create!(first_name: "Dana", last_name: "Calder", email: "dana@theironyard.com",
    password: "password", current_city: "Durham", current_state: "NC", is_cd: true,
    hiring: true, looking: true, sign_in_count: 2)
