require 'yaml'
require 'open-uri'
require 'pexels'

puts "Cleaning the db..."
User.destroy_all
Task.destroy_all
Chask.destroy_all

User.create!({id: 999, email: "chompy@chompiest.com", password: "pass123", password_confirmation: "pass123"})
lucca = User.create!({email: "lucca@test.com", password: "pass123", password_confirmation: "pass123"})
john = User.create!({:email => "john@test.com", :password => "pass123", :password_confirmation => "pass123" })
paul = User.create!({:email => "paul@test.com", :password => "pass123", :password_confirmation => "pass123" })
gui_presentation = User.create!({:email => "guihortinha@test.com", :password => "pass123", :password_confirmation => "pass123" })

puts "Created #{User.count} users!"

travel = Task.new(title: "Travel abroad by myself without any money")
cook = Task.new(title: "Cook a crocodile")
cancer = Task.new(title: "Find a cure to cancer")
job = Task.new(title: "Find a job in web development")
car = Task.new(title: "Fix my 1998 Toyota Camry")

lucca.tasks << [travel, cook, cancer, job, car]

job.chasks << [
  Chask.new(title: "Learn foundational web development languages (HTML, CSS, JavaScript)."),
  Chask.new(title: "Build a portfolio of personal web projects to showcase skills."),
  Chask.new(title: "Gain practical experience through internships or freelance projects."),
  Chask.new(title: "Expand knowledge by exploring frameworks and libraries (e.g., React, Angular)."),
  Chask.new(title: "Network with professionals, attend meetups, and apply for web development positions.")
]

job.chasks.last.chasks << [
  Chask.new(title: "Join online communities and forums related to web development."),
  Chask.new(title: "Engage in discussions, ask questions, and offer assistance to others."),
  Chask.new(title: "Connect with web developers on professional networking platforms like LinkedIn.")
]

cook.chasks << [
  Chask.new(title: "Source fresh crocodile meat from a reputable supplier or farm."),
  Chask.new(title: "Clean and prepare the crocodile meat for cooking."),
  Chask.new(title: "Marinate the meat with spices and seasonings for flavor."),
  Chask.new(title: "Choose a suitable cooking method (grilling, frying, stewing) for the meat."),
  Chask.new(title: "Cook the crocodile meat thoroughly, ensuring it reaches a safe internal temperature."),
]

# # Loop through task_data array to create tasks and associated chasks
# task_data.each do |task_info|
#   task_id = SecureRandom.uuid
#   task = Task.create(title: task_info[:title], completed: task_info[:completed], id: task_id, user_id: user1.id)

#   puts "Expand on Task #{task.id}? (yes/no)"
#   expand_input = gets.chomp.downcase

#   if expand_input == 'yes'
#     chask_id = SecureRandom.uuid
#     chask = Chask.create(title: "Chask for Task #{task.id}", status: 'pending', id: chask_id, task_id: task.id)
#   end
# end

puts "Compleed seeding"
