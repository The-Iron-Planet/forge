# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


d1 = Time.zone.local(2016, 7, 20, 18, 30, 00)
d2 = Time.zone.local(2016, 7, 11, 19, 00, 00)
d3 = Time.zone.local(2016, 8, 1, 17, 30, 00)
d4 = Time.zone.local(2016, 8, 20, 18, 30, 00)
d5 = Time.zone.local(2016, 7, 21, 18, 30, 00)

dur_campus = Campus.create!(city: "Durham", state: "NC")
atl_campus = Campus.create!(city: "Atlanta", state: "GA")

rails = Curriculum.create!(name: "Rails Engineering", nickname: "Rails")
fe = Curriculum.create!(name: "Front End Engineering", nickname: "Front End")
python = Curriculum.create!(name: "Python Engineering", nickname: "Python")
staff = Curriculum.create!(name: "Staff", nickname: "Staff")

dur_rails_course = Course.create!(started_on: "2015-05-04", ended_on: "2015-07-24",
    campus_id: dur_campus.id, curriculum_id: rails.id, cohort: 4)
fe_course = Course.create!(started_on: "2015-05-04", ended_on: "2015-07-24",
    campus_id: dur_campus.id, curriculum_id: fe.id, cohort: 4)
atl_rails_course = Course.create!(started_on: "2015-05-11", ended_on: "2015-07-31",
    campus_id: atl_campus.id, curriculum_id: rails.id, cohort: 4)

dur_cd = User.create!(first_name: "Elise", last_name: "Moen", email: "elise@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "elise_github", is_cd: true, hiring: true, sign_in_count: 2,
    campus_id: dur_campus.id)
atl_cd = User.create!(first_name: "James", last_name: "Douglas", email: "james@test.com",
    password: "password", current_city: "Atlanta", current_state: "GA",
    github_profile: "james_github", is_cd: true, hiring: true, sign_in_count: 2,
    campus_id: atl_campus.id)
dur_rails_alum = User.create!(first_name: "Jane", last_name: "Wilderman", email: "jane@test.com",
    password: "password", current_city: "Raleigh", current_state: "NC",
    github_profile: "jane_github", website: "http://www.janewilderman.com",
    is_cd: false, hiring: false, looking: true, course_id: dur_rails_course.id)
fe_alum = User.create!(first_name: "John", last_name: "Doe", email: "john@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "john_github", is_cd: false, hiring: false, looking: true,
    course_id: fe_course.id)
atl_rails_alum = User.create!(first_name: "Joe", last_name: "Smith", email: "joe@test.com",
    password: "password", current_city: "Decatur", current_state: "GA",
    github_profile: "joe_github", is_cd: false, hiring: true, looking: true,
    course_id: atl_rails_course.id)

Event.create!(name: "July Alumni Meetup",
    description: "Join us at The Iron Yard, Durham AU Campus for some good company, some bites to eat, some networking, and maybe a couple of drinks",
    happens_on: d1, campus_id: dur_campus.id, user_id: dur_cd.id)
Event.create!(name: "Rails Hackathon",
    description: "Bring your projects and let's hack them up.  And by hack, I mean make them better",
    happens_on: d2, campus_id: dur_campus.id, user_id: dur_rails_alum.id)
Event.create!(name: "Front End Meetup",
    description: "Come to the coffee shop and work on some Javascript!  It'll be fun...I promise!",
    happens_on: d3, campus_id: dur_campus.id, user_id: fe_alum.id)
Event.create!(name: "August Alumni Meetup",
    description: "Join us at The Iron Yard, Durham AU Campus for some good company, some bites to eat, some networking, and maybe a couple of drinks",
    happens_on: d4, campus_id: dur_campus.id, user_id: dur_cd.id)
Event.create!(name: "Atlanta Rails Workshop",
    description: "Join us at The Iron Yard, Atlanta Campus to learn about devise, and do some networking!",
    happens_on: d5, campus_id: atl_campus.id, user_id: atl_rails_alum.id)
