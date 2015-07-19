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

dur_rails_course = Course.create!(started_on: "2015-05-04", ended_on: "2015-07-24",
    campus_id: dur_campus.id, curriculum_id: rails.id)
dur_fe_course = Course.create!(started_on: "2015-05-04", ended_on: "2015-07-24",
    campus_id: dur_campus.id, curriculum_id: fe.id)
atl_rails_course = Course.create!(started_on: "2015-05-11", ended_on: "2015-07-31",
    campus_id: atl_campus.id, curriculum_id: rails.id)

dur_cd = User.create!(first_name: "Dana", last_name: "Calder", email: "dana@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "elise_github", is_cd: true, hiring: false, sign_in_count: 2,
    campus_id: dur_campus.id)
atl_cd = User.create!(first_name: "James", last_name: "Douglas", email: "james@test.com",
    password: "password", current_city: "Atlanta", current_state: "GA",
    github_profile: "james_github", is_cd: true, hiring: false, sign_in_count: 2,
    campus_id: atl_campus.id)

dur_rails_instructor = User.create!(first_name: "Mason", last_name: "Matthews", email: "mason@test.com",
    password: "password", current_city: "Hillsborough", current_state: "NC",
    github_profile: "https://github.com/masonfmatthews", is_cd: false, is_instructor: true,
    hiring: true, sign_in_count: 2, campus_id: dur_campus.id, curriculum_id: rails.id)
dur_python_instructor = User.create!(first_name: "Clinton", last_name: "Dreisbach", email: "clinton@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "https://github.com/cndreisbach", is_cd: false, is_instructor: true,
    hiring: false, sign_in_count: 2, campus_id: dur_campus.id, curriculum_id: python.id)
dur_fe_instructor = User.create!(first_name: "Chris", last_name: "Davies", email: "chris@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "https://github.com/chrisdavies", is_cd: false, is_instructor: true,
    hiring: false, sign_in_count: 2, campus_id: dur_campus.id, curriculum_id: fe.id)


dur_rails_alum = User.create!(first_name: "John", last_name: "Wilderman", email: "jane@test.com",
    password: "password", current_city: "Raleigh", current_state: "NC",
    github_profile: "jane_github", website: "http://www.janewilderman.com",
    is_cd: false, hiring: false, looking: true, campus_id: dur_campus.id, curriculum_id: rails.id,
    course_id: dur_rails_course.id)
dur_fe_alum = User.create!(first_name: "John", last_name: "Doe", email: "john@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "john_github", is_cd: false, hiring: true, looking: true,
    campus_id: dur_campus.id, curriculum_id: fe.id, course_id: dur_fe_course.id)
atl_rails_alum = User.create!(first_name: "Joe", last_name: "Smith", email: "joe@test.com",
    password: "password", current_city: "Decatur", current_state: "GA",
    github_profile: "joe_github", is_cd: false, hiring: true, looking: true,
    campus_id: atl_campus.id, curriculum_id: rails.id, course_id: atl_rails_course.id)

Event.create!(title: "July Alumni Meetup", location: "Durham Iron Yard Campus--Student Lounge",
    description: "Join us at The Iron Yard, Durham AU Campus for some good company, some bites to eat, some networking, and maybe a couple of drinks",
    happens_on: d1, campus_id: dur_campus.id, user_id: dur_cd.id)
Event.create!(title: "Rails Hackathon", location: "Smashing Boxes",
    description: "Bring your projects and let's hack them up.  And by hack, I mean make them better",
    happens_on: d2, campus_id: dur_campus.id, user_id: dur_rails_alum.id)
Event.create!(title: "Front End Meetup", location: "Guglhupf--Durham, NC",
    description: "Come to the coffee shop and work on some Javascript!  It'll be fun...I promise!",
    happens_on: d3, campus_id: dur_campus.id, user_id: dur_fe_alum.id)
Event.create!(title: "August Alumni Meetup", location: "Durham Iron Yard Campus--Student Lounge",
    description: "Join us at The Iron Yard, Durham AU Campus for some good company, some bites to eat, some networking, and maybe a couple of drinks",
    happens_on: d4, campus_id: dur_campus.id, user_id: dur_cd.id)
Event.create!(title: "Atlanta Rails Workshop", location: "Atlanta Iron Yard Campus--Rails Classroom",
    description: "Join us at The Iron Yard, Atlanta Campus to learn about devise, and do some networking!",
    happens_on: d5, campus_id: atl_campus.id, user_id: atl_rails_alum.id)

Resource.create!(title: "Learn Javascript", description: "This is a good intro on javascript...seriously.",
    website: "https://www.youtube.com/watch?v=FqhZZNUyVFM", user_id: dur_fe_instructor.id,
    curriculum_id: fe.id)
Resource.create!(title: "Kuku Kube", description: "This game will fine-tune your eye for color.",
    website: "http://kuku-kube.com/", user_id: dur_fe_instructor.id, curriculum_id: fe.id)
Resource.create!(title: "Authenticating API", description: "Ryan Bates is the man!",
    website: "http://railscasts.com/episodes/352-securing-an-api", user_id: dur_rails_instructor.id,
    curriculum_id: rails.id)
Resource.create!(title: "Learn Rails", description: "This is a good intro on rails...I hope",
    website: "https://www.youtube.com/watch?v=PcR6BzeqsG0", user_id: dur_rails_instructor.id,
    curriculum_id: rails.id)
Resource.create!(title: "Learn Javascript", description: "This is a good intro on javascript...I promise",
    website: "https://www.youtube.com/watch?v=FqhZZNUyVFM", user_id: dur_fe_instructor.id,
    curriculum_id: fe.id)
Resource.create!(title: "Learning Python", description: "This book is pretty great.  Let's discuss",
    website: "http://amzn.com/1449355730", user_id: dur_python_instructor.id,
    curriculum_id: python.id)
Resource.create!(title: "Fixed vs. Growth Mindsets", description: "How to fine-tune the internal monologue that scores every aspect of our lives, from leadership to love.",
    website: "http://www.brainpickings.org/2014/01/29/carol-dweck-mindset/",
    user_id: dur_rails_instructor.id, curriculum_id: rails.id)

JobPost.create!(company_name: "Google", city: "Mountain View", state: "CA", user_id: dur_fe_alum.id, curriculum_id: fe.id,
    title: "Front End Engineer", description: "Google is hiring! Those with JavaScript, AJAX, and jQuery experience should apply!",
    experience_desired: "Mid-Level", website: "http://www.google.com", expires_on: (Date.today + 1.month), active: true)
JobPost.create!(company_name: "IBM", city: "Austin", state: "TX", user_id: atl_rails_alum.id, curriculum_id: rails.id,
    title: "Junior Rails Developer", description: "Seeking junior Rails developers with expertise in Ruby, JavaScript, and SQL queries.",
    experience_desired: "Junior Developer", website: "http://www.ibm.com", expires_on: (Date.today + 1.week), active: true)
JobPost.create!(company_name: "IBM", city: "Austin", state: "TX", user_id: atl_rails_alum.id, curriculum_id: python.id,
    title: "Python Developer", description: "Come crunch data for IBM. Python, Django, libraries, and stuff.",
    experience_desired: "Senior Developer", website: "http://www.ibm.com", expires_on: (Date.today + 1.day), active: true)
JobPost.create!(company_name: "Apple", city: "Cupertino", state: "CA", user_id: dur_rails_instructor.id, curriculum_id: rails.id,
    title: "Ruby on Rails Developer", description: "We're the most profitable company in the history of the world. You probably want to work for us. And wear our watches.",
    experience_desired: "Senior Developer", website: "http://www.apple.com", expires_on: (Date.today + 4.day), active: true)
