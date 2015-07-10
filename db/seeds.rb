# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

durham = Campus.create!(city: "Durham", state: "NC")
greenville = Campus.create!(city: "Greenville", state: "SC")
austin = Campus.create!(city: "Austin", state: "TX")
ny = Campus.create!(city: "New York", state: "NY")

rails = Curriculum.create!(name: "Rails Engineering", nickname: "Rails")
front_end = Curriculum.create!(name: "Front End Engineering", nickname: "Front End")
python = Curriculum.create!(name: "Python Engineering", nickname: "Python")
mobile = Curriculum.create!(name: "Mobile Engineering", nickname: "Mobile")
Curriculum.create!(name: "Staff", nickname: "Staff")


d_r_1 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: durham.id,
    curriculum_id: rails.id, cohort: 1)
d_r_2 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: durham.id,
    curriculum_id: rails.id, cohort: 2)
d_r_3 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: durham.id,
    curriculum_id: rails.id, cohort: 3)
d_f_1 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: durham.id,
    curriculum_id: front_end.id, cohort: 1)
d_f_2 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: durham.id,
    curriculum_id: front_end.id, cohort: 2)
d_p_1 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: durham.id,
    curriculum_id: python.id, cohort: 1)
d_p_2 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: durham.id,
    curriculum_id: python.id, cohort: 2)

g_r_1 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: greenville.id,
    curriculum_id: rails.id, cohort: 1)
g_r_2 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: greenville.id,
    curriculum_id: rails.id, cohort: 2)
g_r_3 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: greenville.id,
    curriculum_id: rails.id, cohort: 3)
g_f_1 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: greenville.id,
    curriculum_id: front_end.id, cohort: 1)
g_f_2 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: greenville.id,
    curriculum_id: front_end.id, cohort: 2)
g_p_1 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: greenville.id,
    curriculum_id: python.id, cohort: 1)
g_p_2 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: greenville.id,
    curriculum_id: python.id, cohort: 2)

a_r_1 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: austin.id,
    curriculum_id: rails.id, cohort: 1)
a_r_2 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: austin.id,
    curriculum_id: rails.id, cohort: 2)
a_r_3 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: austin.id,
    curriculum_id: rails.id, cohort: 3)
a_f_1 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: austin.id,
    curriculum_id: front_end.id, cohort: 1)
a_f_2 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: austin.id,
    curriculum_id: front_end.id, cohort: 2)

n_m_0 = Course.create!(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: ny.id,
    curriculum_id: mobile.id, cohort: 1)

User.create!(first_name: "Dana", last_name: "Calder", email: "dana@theironyard.com",
    password: "password", current_city: "Durham", current_state: "NC", is_cd: true,
    hiring: true, looking: true, sign_in_count: 2)

5.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email,
      password: "password", current_city: "Durham", current_state: "NC", is_cd: true, course_id: d_r_1.id,
      hiring: false, looking: true, sign_in_count: 2)
end

5.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email,
      password: "password", current_city: "Durham", current_state: "NC", is_cd: true, course_id: d_r_1.id,
      hiring: false, looking: false, sign_in_count: 2)
end

5.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email,
      password: "password", current_city: "Chapel Hill", current_state: "NC", is_cd: true, course_id: d_r_1.id,
      hiring: false, looking: true, sign_in_count: 2)
end

5.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email,
      password: "password", current_city: "Durham", current_state: "NC", is_cd: true, course_id: a_r_2.id,
      hiring: false, looking: true, sign_in_count: 2)
end

5.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email,
      password: "password", current_city: "Durham", current_state: "NC", is_cd: true, course_id: a_r_2.id,
      hiring: false, looking: false, sign_in_count: 2)
end

5.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email,
      password: "password", current_city: "Chapel Hill", current_state: "NC", is_cd: true, course_id: a_r_2.id,
      hiring: false, looking: true, sign_in_count: 2)
end
