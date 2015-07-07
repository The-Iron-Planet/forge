# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name: "Elise", last_name: "Moen", email: "elise@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "elise_github", is_cd: true, hiring: true)
User.create!(first_name: "Jane", last_name: "Wilderman", email: "jane@test.com",
    password: "password", current_city: "Raleigh", current_state: "NC",
    github_profile: "jane_github", website: "http://www.janewilderman.com",
    is_cd: false, hiring: false, looking: true)
