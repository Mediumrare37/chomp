require 'yaml'
require 'open-uri'
require 'pexels'

puts "Cleaning the db..."
Chask.destroy_all
Task.destroy_all
User.destroy_all

john = User.create!({:email => "john@test.com", :password => "pass123", :password_confirmation => "pass123" })
paul = User.create!({:email => "paul@test.com", :password => "pass123", :password_confirmation => "pass123" })
gui_presentation = User.create!({:email => "guihortinha@test.com", :password => "pass123", :password_confirmation => "pass123" })

puts "Created #{User.count} users!"

# to Create users
# user1 = User.create(name: 'User 1')
# user2 = User.create(name: 'User 2')

# To create random id numbers
task1 = Task.create(title: 'Task 1', completed: false, user: john)
task2 = Task.create(title: 'Task 2', completed: true, user: paul)


puts "Creating chasks"
chask1 = Chask.create(title: 'Chask 1', status: 'pending', task_id: task1.id)
chask2 = Chask.create(title: 'Chask 2', status: 'completed', task_id: task1.id)
chask3 = Chask.create(title: 'Chask 3', status: 'pending', task_id: task2.id)
chask4 = Chask.create(title: 'Chask 4', status: 'completed', task_id: task2.id)

puts "Created #{Chask.count} chasks!"


# Loop through task_data array to create tasks and associated chasks
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

puts "Created #{Task.count} tasks!"

# 30.times do
#   new_chask = Chask.new({
#     title: 'Check visa situation',
#     status: Chask::STATUS.sample
#   })

#   new_chask.task = Task.all.sample
#   new_chask.save!
# end

# puts "Completed seeding"

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

# puts "Compleed seeding"
