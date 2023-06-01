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

travel = Task.create!(title: "Travel abroad by myself without any money", deadline: Date.today + 30, user: lucca)
parcel = Task.create!(title: "Send a parcel from Japan to the US", completed: true, user: lucca)
job = Task.create!(title: "Find a job in web development", deadline: Date.today + 20, user: lucca)
car = Task.create!(title: "Fix my 1998 Toyota Camry", deadline: Date.today + 10, user: lucca)

# lucca.tasks << [travel, parcel, job, car]
# john.tasks << [travel, parcel, job, car]
# paul.tasks << [travel, parcel, job, car]
# gui_presentation.tasks << [travel, parcel, job, car]

# Travel - chask 2 has subchasks, nothing completed

travel.chasks << [
  Chask.new(title: "Research low-cost destinations", status: 'queued'),
  Chask.new(title: "Plan a budget"),
  Chask.new(title: "Save money beforehand"),
  Chask.new(title: "Explore volunteering opportunities"),
  Chask.new(title: "Use alternative accommodation options'")
  ]

  Chask.create!(title: 'Identify countries or cities with low living costs', status: 'unrequested', chask: travel.chasks[0], task: travel)
  Chask.create!(title: 'Look for affordable accommodation options such as hostels or budget hotels', status: 'unrequested', chask: travel.chasks[0], task: travel)
  Chask.create!(title: 'Consider destinations with low-cost transportation options', status: 'unrequested', chask: travel.chasks[0], task: travel)


  Chask.create!(title: 'Calculate estimated expenses for accommodation, food, and transportation', chask: travel.chasks[1], task: travel)
  Chask.create!(title: 'Set a daily spending limit and track your expenses', chask: travel.chasks[1], task: travel)
  Chask.create!(title: 'Look for free or low-cost activities and attractions', chask: travel.chasks[1], task: travel)

  Chask.create!(title: 'Cut down on unnecessary expenses and save as much as possible', status: 'unrequested', chask: travel.chasks[2], task: travel)
  Chask.create!(title: 'Create a savings plan and stick to it', status: 'unrequested', chask: travel.chasks[2], task: travel)
  Chask.create!(title: 'Consider taking up temporary jobs or freelancing to earn extra money', status: 'unrequested', chask: travel.chasks[2], task: travel)

  Chask.create!(title: 'Look for volunteering programs that offer accommodation and meals', status: 'unrequested', chask: travel.chasks[3], task: travel)
  Chask.create!(title: 'Consider volunteering in exchange for room and board', status: 'unrequested', chask: travel.chasks[3], task: travel)
  Chask.create!(title: 'Research organizations that provide opportunities for travelers', status: 'unrequested', chask: travel.chasks[3], task: travel)

  Chask.create!(title: 'Consider couchsurfing or house-sitting as options for free accommodation', status: 'unrequested', chask: travel.chasks[4], task: travel)
  Chask.create!(title: 'Look for opportunities to exchange work for accommodation', status: 'unrequested', chask: travel.chasks[4], task: travel)
  Chask.create!(title: 'Connect with locals who may offer a place to stay', status: 'unrequested', chask: travel.chasks[4], task: travel)

# Parcel - no subchasks, all chasks completed

parcel.chasks << [
  Chask.new(title: "Check the shipping regulations and restrictions", status: 'completed'),
  Chask.new(title: "Package the contents securely.", status: 'completed'),
  Chask.new(title: "Choose a shipping service and carrier", status: 'completed'),
  Chask.new(title: "Fill out the necessary shipping forms", status: 'completed'),
  Chask.new(title: "Track the shipment and ensure delivery", status: 'completed')
  ]

  Chask.create!(title: 'Research the prohibited and restricted items for international shipping', status: 'unrequested', chask: travel.chasks[0], task: parcel)
  Chask.create!(title: 'Ensure compliance with customs requirements and documentation', status: 'unrequested', chask: travel.chasks[0], task: parcel)
  Chask.create!(title: 'Verify any additional regulations for specific items or materials', status: 'unrequested', chask: travel.chasks[0], task: parcel)

  Chask.create!(title: 'Select appropriate packaging materials based on the contents', status: 'unrequested', chask: travel.chasks[1], task: parcel)
  Chask.create!(title: 'Use cushioning materials to protect fragile items', status: 'unrequested', chask: travel.chasks[1], task: parcel)
  Chask.create!(title: 'Seal the package properly to prevent damage or tampering', status: 'unrequested', chask: travel.chasks[1], task: parcel)

  Chask.create!(title: 'Compare different shipping services and their features', status: 'unrequested', chask: travel.chasks[2], task: parcel)
  Chask.create!(title: 'Consider factors like speed, cost, and tracking options', status: 'unrequested', chask: travel.chasks[2], task: parcel)
  Chask.create!(title: 'Select a reliable carrier with a good track record', status: 'unrequested', chask: travel.chasks[2], task: parcel)

  Chask.create!(title: 'Provide accurate sender and recipient information', status: 'unrequested', chask: travel.chasks[3], task: parcel)
  Chask.create!(title: 'Include a detailed description of the parcel contents', status: 'unrequested', chask: travel.chasks[3], task: parcel)
  Chask.create!(title: 'Complete any customs forms or declarations', status: 'unrequested', chask: travel.chasks[3], task: parcel)

  Chask.create!(title: 'Obtain a tracking number and monitor the progress online', status: 'unrequested', chask: travel.chasks[4], task: parcel)
  Chask.create!(title: 'Contact the carrier if there are any delays or issues', status: 'unrequested', chask: travel.chasks[4], task: parcel)
  Chask.create!(title: 'Confirm the delivery with the recipient', status: 'unrequested', chask: travel.chasks[4], task: parcel)

# Job - subchasks on chask 2, different status

job.chasks << [
  Chask.new(title: "Update your resume and portfolio", status: 'completed'),
  Chask.new(title: "Research job market and trends", status: 'progress'),
  Chask.new(title: "Network with professionals in the field", status: 'excluded'),
  Chask.new(title: "Prepare for technical interviews", status: 'queued'),
  Chask.new(title: "Apply to web development job openings")
]

  Chask.create!(title: 'Add recent web development projects and experiences', status: 'unrequested', chask: travel.chasks[0], task: job)
  Chask.create!(title: 'Highlight relevant skills like HTML, CSS, and JavaScript', status: 'unrequested', chask: travel.chasks[0], task: job)
  Chask.create!(title: 'Include links to your GitHub or portfolio website', status: 'unrequested', chask: travel.chasks[0], task: job)

  Chask.create!(title: 'Identify in-demand web development technologies and frameworks', status: 'queued', chask: travel.chasks[1], task: job)
  Chask.create!(title: 'Explore job boards and websites for web development positions', status: 'paused', chask: travel.chasks[1], task: job)
  Chask.create!(title: 'Stay updated on industry news and emerging trends', status: 'queued', chask: travel.chasks[1], task: job)

  Chask.create!(title: 'Attend web development meetups and networking events', status: 'unrequested', chask: travel.chasks[2], task: job)
  Chask.create!(title: 'Connect with web developers on professional social platforms', status: 'unrequested', chask: travel.chasks[2], task: job)
  Chask.create!(title: 'Seek mentorship or advice from experienced professionals', status: 'unrequested', chask: travel.chasks[2], task: job)

  Chask.create!(title: 'Practice coding exercises and algorithms in JavaScript', status: 'unrequested', chask: travel.chasks[3], task: job)
  Chask.create!(title: 'Review web development concepts and best practices', status: 'unrequested', chask: travel.chasks[3], task: job)
  Chask.create!(title: 'Brush up on common interview questions and problem-solving techniques', status: 'unrequested', chask: travel.chasks[3], task: job)

  Chask.create!(title: 'Tailor your resume and cover letter for each application', status: 'unrequested', chask: travel.chasks[4], task: job)
  Chask.create!(title: 'Submit your application through online job portals or company websites', status: 'unrequested', chask: travel.chasks[4], task: job)
  Chask.create!(title: 'Follow up with potential employers after submitting your application', status: 'unrequested', chask: travel.chasks[4], task: job)

# Car

car.chasks << [
  Chask.new(title: "Diagnose the issues", status: 'completed'),
  Chask.new(title: "Repair or replace faulty components", status: 'completed'),
  Chask.new(title: "Perform regular maintenance", status: 'completed'),
  Chask.new(title: "Check and refill fluids", status: 'excluded'),
  Chask.new(title: "Ensure proper alignment and balances", status: 'paused')
]

  Chask.create!(title: 'Perform a comprehensive inspection of the vehicle', status: 'unrequested', chask: travel.chasks[0], task: car)
  Chask.create!(title: 'Identify any warning signs or symptoms of malfunction', status: 'unrequested', chask: travel.chasks[0], task: car)
  Chask.create!(title: 'Use diagnostic tools to retrieve error codes (if applicable)', status: 'unrequested', chask: travel.chasks[0], task: car)

  Chask.create!(title: 'Fix or replace malfunctioning engine parts', status: 'unrequested', chask: travel.chasks[1], task: car)
  Chask.create!(title: 'Repair or replace worn-out brakes, suspension, or steering components', status: 'unrequested', chask: travel.chasks[1], task: car)
  Chask.create!(title: 'Address electrical issues and faulty wiring', status: 'unrequested', chask: travel.chasks[1], task: car)

  Chask.create!(title: 'Change the engine oil and oil filter', status: 'unrequested', chask: travel.chasks[2], task: car)
  Chask.create!(title: 'Replace the air filter and spark plugs', status: 'unrequested', chask: travel.chasks[2], task: car)
  Chask.create!(title: 'Inspect and rotate the tires, and check the tire pressure', status: 'unrequested', chask: travel.chasks[2], task: car)

  Chask.create!(title: 'Inspect the coolant, brake fluid, and transmission fluid levels', status: 'unrequested', chask: travel.chasks[3], task: car)
  Chask.create!(title: 'Refill or replace fluids as needed', status: 'unrequested', chask: travel.chasks[3], task: car)
  Chask.create!(title: 'Flush and replace old coolant or brake fluid if necessary', status: 'unrequested', chask: travel.chasks[3], task: car)

  Chask.create!(title: 'Check the wheel alignment and adjust if needed', status: 'unrequested', chask: travel.chasks[4], task: car)
  Chask.create!(title: 'Balance the tires to prevent uneven wear', status: 'unrequested', chask: travel.chasks[4], task: car)
  Chask.create!(title: 'Inspect and replace worn-out or damaged suspension components', status: 'unrequested', chask: travel.chasks[4], task: car)

puts "Compleed seeding"
