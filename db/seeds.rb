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

10.times do
  new_chask = Chask.new({
    title: 'Check visa situation',
    status: Chask::STATUS.sample
  })

  new_chask.task = Task.all.sample
  new_chask.save!
end

puts "Created #{Chask.count} chasks!"
