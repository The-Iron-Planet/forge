# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


d1 = Time.zone.local(2016, 7, 30, 18, 30, 00)
d2 = Time.zone.local(2016, 8, 5, 19, 00, 00)
d3 = Time.zone.local(2016, 8, 3, 17, 30, 00)
d4 = Time.zone.local(2016, 8, 27, 18, 30, 00)
d5 = Time.zone.local(2016, 8, 15, 14, 00, 00)
d6 = Time.zone.local(2016, 7, 24, 14, 00, 00)

dur_campus = Campus.create!(city: "Durham", state: "NC")
atl_campus = Campus.create!(city: "Atlanta", state: "GA")
austin_campus = Campus.create!(city: "Austin", state: "TX")
charleston_campus = Campus.create!(city: "Charleston", state: "SC")
columbia_campus = Campus.create!(city: "Columbia", state: "SC")
greenville_campus = Campus.create!(city: "Greenville", state: "SC")
houston_campus = Campus.create!(city: "Houston", state: "TX")
indy_campus = Campus.create!(city: "Indianapolis", state: "IN")
little_rock_campus = Campus.create!(city: "Little Rock", state: "AR")
nashville_campus = Campus.create!(city: "Nashville", state: "TN")
orlando_campus = Campus.create!(city: "Orlando", state: "FL")
tampa_campus = Campus.create!(city: "Tampa Bay", state: "FL")
dc_campus = Campus.create!(city: "Washington, DC", state: "DC")


rails = Curriculum.create!(name: "Rails Engineering", nickname: "Rails")
fe = Curriculum.create!(name: "Front End Engineering", nickname: "Front End")
python = Curriculum.create!(name: "Python Engineering", nickname: "Python")
mobile = Curriculum.create!(name: "Mobile Engineering", nickname: "Mobile")
ui_design = Curriculum.create!(name: "User Interface Design", nickname: "UI")
net = Curriculum.create!(name: ".NET Engineering", nickname: ".NET")


dur_rails_course = Course.create!(started_on: "2015-05-04", ended_on: "2015-07-24",
    campus_id: dur_campus.id, curriculum_id: rails.id)
dur_fe_course = Course.create!(started_on: "2015-05-04", ended_on: "2015-07-24",
    campus_id: dur_campus.id, curriculum_id: fe.id)
dur_python_course = Course.create!(started_on: "2015-05-04", ended_on: "2015-07-24",
    campus_id: dur_campus.id, curriculum_id: python.id)




30.times do
  campus = Campus.all.sample
  curriculum = Curriculum.all.sample
  start_day = (1..7).to_a.sample
  end_day = (21..28).to_a.sample
  start_month = (1..6).to_a.sample
  end_month = start_month + 3

  course = Course.create!(started_on: "2015-#{start_month}-#{start_day}", ended_on: "2015-#{end_month}-#{end_day}",
      campus_id: campus.id, curriculum_id: curriculum.id)

  num = (1..100).to_a.sample
  if num < 50
    mentor = true
  else
    mentor = false
  end

  num = (1..100).to_a.sample
  if num < 50
    hiring = true
  else
    hiring = false
  end

  user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
      password: "password", current_city: campus.city, current_state: campus.state,
      is_cd: false, is_instructor: false, hiring: hiring, looking: false, campus_id: campus.id,
      curriculum_id: curriculum.id, course_id: course.id, is_mentor: mentor)
  user.email = "#{user.first_name}@test.com"
  user.github_profile = "#{user.first_name}"
  user.slack_handle = "#{user.first_name}"
  user.save!
end


dur_cd = User.create!(first_name: "Dana", last_name: "Calder", email: "dana@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    is_cd: true, hiring: false, sign_in_count: 2, campus_id: dur_campus.id)


dur_rails_instructor = User.create!(first_name: "Mason", last_name: "Matthews", email: "mason@test.com",
    password: "password", current_city: "Hillsborough", current_state: "NC",
    github_profile: "masonfmatthews", is_cd: false, is_instructor: true,
    hiring: true, sign_in_count: 2, campus_id: dur_campus.id, curriculum_id: rails.id, is_mentor: true)
dur_python_instructor = User.create!(first_name: "Clinton", last_name: "Dreisbach", email: "clinton@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "cndreisbach", is_cd: false, is_instructor: true,
    hiring: false, sign_in_count: 2, campus_id: dur_campus.id, curriculum_id: python.id, is_mentor: true)
dur_fe_instructor = User.create!(first_name: "Chris", last_name: "Davies", email: "chris@test.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "chrisdavies", is_cd: false, is_instructor: true,
    hiring: false, sign_in_count: 2, campus_id: dur_campus.id, curriculum_id: fe.id, is_mentor: true)


jmbuscemi = User.create!(first_name: "John", last_name: "Buscemi", email: "jmbuscemi@gmail.com",
    password: "password", current_city: "Raleigh", current_state: "NC",
    github_profile: "jmbuscemi", twitter: "jmbuscemi", slack_handle: "jmbuscemi",
    is_cd: false, hiring: false, looking: true, campus_id: dur_campus.id, curriculum_id: rails.id,
    course_id: dur_rails_course.id, sign_in_count: 2, is_mentor: true)
jcreiff = User.create!(first_name: "Joe", last_name: "Reiff", email: "jcreiff@gmail.com",
    password: "password", current_city: "Chapel Hill", current_state: "NC",
    github_profile: "jcreiff", slack_handle: "jcreiff", is_cd: false, hiring: false,
    looking: true, campus_id: dur_campus.id, curriculum_id: rails.id,
    course_id: dur_rails_course.id, sign_in_count: 2, is_mentor: false)
elizabeth = User.create!(first_name: "Elizabeth", last_name: "Shealy", email: "elizabeth.shealy@gmail.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "elizabethshealy", slack_handle: "elizabethshealy", is_cd: false, hiring: false,
    looking: true, campus_id: dur_campus.id, curriculum_id: fe.id,
    course_id: dur_fe_course.id, sign_in_count: 2, is_mentor: false)
patti = User.create!(first_name: "Patti", last_name: "Mackay", email: "pmackay71@hotmail.com",
    password: "password", current_city: "Durham", current_state: "NC",
    github_profile: "NotoriousPAT", slack_handle: "patti-mackay", is_cd: false, hiring: false,
    looking: true, campus_id: dur_campus.id, curriculum_id: fe.id,
    course_id: dur_fe_course.id, sign_in_count: 2, is_mentor: false)


Event.create!(title: "July Alumni Meetup", location: "Durham Iron Yard Campus--Student Lounge",
    description: "Join us at The Iron Yard, Durham AU Campus for some good company, some bites to eat, some networking, and maybe a couple of drinks",
    happens_on: d1, campus_id: dur_campus.id, user_id: dur_cd.id)
Event.create!(title: "MasonCon - Part 2", location: "Mason's Game Emporium",
    description: "Come over and eat some Chinese take out and see if you can beat me at Mario Kart",
    happens_on: d2, campus_id: dur_campus.id, user_id: dur_rails_instructor.id)
Event.create!(title: "Front End Meetup", location: "Cocoa Cinnamon--Durham, NC",
    description: "Come to the coffee shop and work on some Javascript!  It'll be fun...I promise!",
    happens_on: d3, campus_id: dur_campus.id, user_id: dur_fe_instructor.id)
Event.create!(title: "August Alumni Meetup", location: "Durham Iron Yard Campus--Student Lounge",
    description: "Join us at The Iron Yard, Durham AU Campus for some good company, some bites to eat, some networking, and maybe a couple of drinks",
    happens_on: d4, campus_id: dur_campus.id, user_id: dur_cd.id)
Event.create!(title: "Python Pig Pickin", location: "Clinton's Back Yard",
    description: "Alliteration is fun, so let's have a pretty perfect python party where we pick a pig clean!",
    happens_on: d5, campus_id: dur_campus.id, user_id: dur_python_instructor.id)
Event.create!(title: "Demo Day!!", location: "Full Frame Theatre -- Durham, NC",
    description: "It's time to show off what you've learned at The Iron Yard.  Stick around after all groups have presented to network with the companies in attendance.",
    happens_on: d6, campus_id: dur_campus.id, user_id: dur_cd.id)

Resource.create!(title: "Learn Javascript", description: "This is a good intro on javascript...seriously.",
    website: "https://www.youtube.com/watch?v=FqhZZNUyVFM", user_id: dur_fe_instructor.id,
    curriculum_id: fe.id)
Resource.create!(title: "Kuku Kube", description: "This game will fine-tune your eye for color.",
    website: "http://kuku-kube.com/", user_id: dur_fe_instructor.id, curriculum_id: fe.id)
Resource.create!(title: "Authenticating API", description: "Ryan Bates is the man!",
    website: "http://railscasts.com/episodes/352-securing-an-api", user_id: dur_rails_instructor.id,
    curriculum_id: rails.id)
Resource.create!(title: "Rails Intro", description: "This is a good intro on rails...I hope",
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

JobPost.create!(company_name: "Google", location: "Mountain View, CA", user_id: dur_cd.id, curriculum_id: fe.id,
    title: "Front End Engineer", description: "Google is hiring! Those with JavaScript, AJAX, and jQuery experience should apply!",
    experience_desired: "Mid-Level", website: "http://www.google.com", expires_on: (Date.today + 1.month), active: true)
JobPost.create!(company_name: "IBM", location: "Austin, TX", user_id: dur_cd.id, curriculum_id: rails.id,
    title: "Junior Rails Developer", description: "Seeking junior Rails developers with expertise in Ruby, JavaScript, and SQL queries.",
    experience_desired: "Junior Developer", website: "http://www.ibm.com", expires_on: (Date.today + 1.week), active: true)
JobPost.create!(company_name: "IBM", location: "Austin, TX", user_id: dur_cd.id, curriculum_id: python.id,
    title: "Python Developer", description: "Come crunch data for IBM. Python, Django, libraries, and stuff.",
    experience_desired: "Senior Developer", website: "http://www.ibm.com", expires_on: (Date.today + 1.day), active: true)
JobPost.create!(company_name: "Apple", location: "Cupertino, CA", user_id: dur_cd.id, curriculum_id: rails.id,
    title: "Ruby on Rails Developer", description: "We're the most profitable company in the history of the world. You probably want to work for us. And wear our watches.",
    experience_desired: "Senior Developer", website: "http://www.apple.com", expires_on: (Date.today + 4.day), active: true)
