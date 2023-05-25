require 'yaml'
require 'open-uri'
require 'pexels'

puts "Cleaning the db..."
User.destroy_all
Task.destroy_all
Chask.destroy_all

john = User.create!({:email => "john@test.com", :password => "pass123", :password_confirmation => "pass123" })
paul = User.create!({:email => "paul@test.com", :password => "pass123", :password_confirmation => "pass123" })
gui_presentation = User.create!({:email => "guihortinha@test.com", :password => "pass123", :password_confirmation => "pass123" })

puts "Created #{User.count} users!"

10.times do
  new_task = Task.new({
    title: 'Find a job in Canada',
    })

  new_task.user = paul
  new_task.save!
  end

puts "Created #{Task.count} tasks!"

30.times do
  new_chask = Chask.new({
    title: 'Check visa situation',
    status: Chask::STATUS.sample
  })

  new_chask.task = Task.all.sample
  new_chask.save!
end

puts "Created #{Chask.count} chasks!"

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
