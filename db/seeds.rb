# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name: "Elise", last_name: "Moen", email: "elise@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "elise_github", is_cd: true, hiring: true, sign_in_count: 2)
User.create!(first_name: "Jane", last_name: "Wilderman", email: "jane@test.com",
    password: "password", current_city: "Raleigh", current_state: "NC",
    github_profile: "jane_github", website: "http://www.janewilderman.com",
    is_cd: false, hiring: false, looking: true)
User.create!(first_name: "Harvey", last_name: "Ruecker", email: "harvey@test.com",
    password: "password", current_city: "Chapel Hill", current_state: "NC",
    github_profile: "harvey_github", is_cd: false, hiring: true, looking: true)
User.create!(first_name: "Brett", last_name: "Murazik", email: "brett@test.com",
    password: "password", current_city: "Hillsborough", current_state: "NC",
    github_profile: "brett_github", website: "http://www.brett-murazick.com",
    blog: "http://murazick.blogspot.com", is_cd: false, hiring: false, looking: false)

User.create!(first_name: "Talia", last_name: "Lind", email: "talia@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "talia_github", is_cd: false, hiring: true, looking: true)
User.create!(first_name: "Arnoldo", last_name: "Weber", email: "arnaldo@test.com",
    password: "password", current_city: "Raleigh", current_state: "NC",
    github_profile: "arnaldo_github", website: "http://www.arnaldo.com",
    is_cd: false, hiring: true, looking: true)
User.create!(first_name: "Arlene", last_name: "Corwin", email: "arlene@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "arlene_github", website: "http://www.arlenecorwin.com",
    blog: "http://arlenecorwin.blogspot.com", is_cd: false, hiring: false, looking: false)
User.create!(first_name: "Patrick", last_name: "Rowe", email: "patrick@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "patrick_github", blog: "http://patrickrowe.blogspot.com",
    is_cd: false, hiring: false, looking: false)


Campus.create!(city: "Durham", state: "NC")

Curriculum.create!(name: "Rails Engineering")
Curriculum.create!(name: "Front End Engineering")
Curriculum.create!(name: "Python Engineering")
