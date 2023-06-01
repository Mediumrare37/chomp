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

travel = Task.new(title: "Travel abroad by myself without any money", deadline: Date.today + 30)
parcel = Task.new(title: "Send a parcel from Japan to the US", completed: true)
job = Task.new(title: "Find a job in web development", deadline: Date.today + 20)
car = Task.new(title: "Fix my 1998 Toyota Camry", deadline: Date.today + 10)

lucca.tasks << [travel, parcel, job, car]
john.tasks << [travel, parcel, job, car]
paul.tasks << [travel, parcel, job, car]
gui_presentation.tasks << [travel, parcel, job, car]

# Travel - chask 2 has subchasks, nothing completed

travel.chasks << [
  Chask.new(title: "Research low-cost destinations", status: 'queued'),
  Chask.new(title: "Plan a budget"),
  Chask.new(title: "Save money beforehand"),
  Chask.new(title: "Explore volunteering opportunities"),
  Chask.new(title: "Use alternative accommodation options'")
  ]

travel.chasks[0].chasks << [
  Chask.new(title: 'Identify countries or cities with low living costs', status: 'unrequested'),
  Chask.new(title: 'Look for affordable accommodation options such as hostels or budget hotels', status: 'unrequested'),
  Chask.new(title: 'Consider destinations with low-cost transportation options', status: 'unrequested')
]

travel.chasks[1].chasks << [
  Chask.new(title: 'Calculate estimated expenses for accommodation, food, and transportation'),
  Chask.new(title: 'Set a daily spending limit and track your expenses'),
  Chask.new(title: 'Look for free or low-cost activities and attractions')
]

travel.chasks[2].chasks << [
  Chask.new(title: 'Cut down on unnecessary expenses and save as much as possible', status: 'unrequested'),
  Chask.new(title: 'Create a savings plan and stick to it', status: 'unrequested'),
  Chask.new(title: 'Consider taking up temporary jobs or freelancing to earn extra money', status: 'unrequested')
]

travel.chasks[3].chasks << [
  Chask.new(title: 'Look for volunteering programs that offer accommodation and meals', status: 'unrequested'),
  Chask.new(title: 'Consider volunteering in exchange for room and board', status: 'unrequested'),
  Chask.new(title: 'Research organizations that provide opportunities for travelers', status: 'unrequested')
]

travel.chasks[4].chasks << [
  Chask.new(title: 'Consider couchsurfing or house-sitting as options for free accommodation', status: 'unrequested'),
  Chask.new(title: 'Look for opportunities to exchange work for accommodation', status: 'unrequested'),
  Chask.new(title: 'Connect with locals who may offer a place to stay', status: 'unrequested')
]

# Parcel - no subchasks, all chasks completed

parcel.chasks << [
  Chask.new(title: "Check the shipping regulations and restrictions", status: 'completed'),
  Chask.new(title: "Package the contents securely.", status: 'completed'),
  Chask.new(title: "Choose a shipping service and carrier", status: 'completed'),
  Chask.new(title: "Fill out the necessary shipping forms", status: 'completed'),
  Chask.new(title: "Track the shipment and ensure delivery", status: 'completed')
  ]

parcel.chasks[0].chasks << [
  Chask.new(title: 'Research the prohibited and restricted items for international shipping', status: 'unrequested'),
  Chask.new(title: 'Ensure compliance with customs requirements and documentation', status: 'unrequested'),
  Chask.new(title: 'Verify any additional regulations for specific items or materials', status: 'unrequested')
]

parcel.chasks[1].chasks << [
  Chask.new(title: 'Select appropriate packaging materials based on the contents', status: 'unrequested'),
  Chask.new(title: 'Use cushioning materials to protect fragile items', status: 'unrequested'),
  Chask.new(title: 'Seal the package properly to prevent damage or tampering', status: 'unrequested')
]

parcel.chasks[2].chasks << [
  Chask.new(title: 'Compare different shipping services and their features', status: 'unrequested'),
  Chask.new(title: 'Consider factors like speed, cost, and tracking options', status: 'unrequested'),
  Chask.new(title: 'Select a reliable carrier with a good track record', status: 'unrequested'),
]

parcel.chasks[3].chasks << [
  Chask.new(title: 'Provide accurate sender and recipient information', status: 'unrequested'),
  Chask.new(title: 'Include a detailed description of the parcel contents', status: 'unrequested'),
  Chask.new(title: 'Complete any customs forms or declarations', status: 'unrequested')
]

parcel.chasks[4].chasks << [
  Chask.new(title: 'Obtain a tracking number and monitor the progress online', status: 'unrequested'),
  Chask.new(title: 'Contact the carrier if there are any delays or issues', status: 'unrequested'),
  Chask.new(title: 'Confirm the delivery with the recipient', status: 'unrequested')
]

# Job - subchasks on chask 2, different status

job.chasks << [
  Chask.new(title: "Update your resume and portfolio", status: 'completed'),
  Chask.new(title: "Research job market and trends", status: 'progress'),
  Chask.new(title: "Network with professionals in the field", status: 'excluded'),
  Chask.new(title: "Prepare for technical interviews", status: 'queued'),
  Chask.new(title: "Apply to web development job openings")
]

job.chasks[0].chasks << [
  Chask.new(title: 'Add recent web development projects and experiences', status: 'unrequested'),
  Chask.new(title: 'Highlight relevant skills like HTML, CSS, and JavaScript', status: 'unrequested'),
  Chask.new(title: 'Include links to your GitHub or portfolio website', status: 'unrequested'),
]

job.chasks[1].chasks << [
  Chask.new(title: 'Identify in-demand web development technologies and frameworks', status: 'queued'),
  Chask.new(title: 'Explore job boards and websites for web development positions', status: 'paused'),
  Chask.new(title: 'Stay updated on industry news and emerging trends', status: 'queued')
]

job.chasks[2].chasks << [
  Chask.new(title: 'Attend web development meetups and networking events', status: 'unrequested'),
  Chask.new(title: 'Connect with web developers on professional social platforms', status: 'unrequested'),
  Chask.new(title: 'Seek mentorship or advice from experienced professionals', status: 'unrequested')
]

job.chasks[3].chasks << [
  Chask.new(title: 'Practice coding exercises and algorithms in JavaScript', status: 'unrequested'),
  Chask.new(title: 'Review web development concepts and best practices', status: 'unrequested'),
  Chask.new(title: 'Brush up on common interview questions and problem-solving techniques', status: 'unrequested'),
]

job.chasks[4].chasks << [
  Chask.new(title: 'Tailor your resume and cover letter for each application', status: 'unrequested'),
  Chask.new(title: 'Submit your application through online job portals or company websites', status: 'unrequested'),
  Chask.new(title: 'Follow up with potential employers after submitting your application', status: 'unrequested')
]

# Car

car.chasks << [
  Chask.new(title: "Diagnose the issues", status: 'completed'),
  Chask.new(title: "Repair or replace faulty components", status: 'completed'),
  Chask.new(title: "Perform regular maintenance", status: 'completed'),
  Chask.new(title: "Prepare for technical interviews", status: 'excluded'),
  Chask.new(title: "Apply to web development job openings", status: 'paused')
]

car.chasks[0].chasks << [
  Chask.new(title: 'Perform a comprehensive inspection of the vehicle', status: 'unrequested'),
  Chask.new(title: 'Identify any warning signs or symptoms of malfunction', status: 'unrequested'),
  Chask.new(title: 'Use diagnostic tools to retrieve error codes (if applicable)', status: 'unrequested')
]

car.chasks[1].chasks << [
  Chask.new(title: 'Fix or replace malfunctioning engine parts', status: 'unrequested'),
  Chask.new(title: 'Repair or replace worn-out brakes, suspension, or steering components', status: 'unrequested'),
  Chask.new(title: 'Address electrical issues and faulty wiring', status: 'unrequested')
]

car.chasks[2].chasks << [
  Chask.new(title: 'Change the engine oil and oil filter', status: 'unrequested'),
  Chask.new(title: 'Replace the air filter and spark plugs', status: 'unrequested'),
  Chask.new(title: 'Inspect and rotate the tires, and check the tire pressure', status: 'unrequested')
]

car.chasks[3].chasks << [
  Chask.new(title: 'Inspect the coolant, brake fluid, and transmission fluid levels', status: 'unrequested'),
  Chask.new(title: 'Refill or replace fluids as needed', status: 'unrequested'),
  Chask.new(title: 'Flush and replace old coolant or brake fluid if necessary', status: 'unrequested'),
]

car.chasks[4].chasks << [
  Chask.new(title: 'Check the wheel alignment and adjust if needed', status: 'unrequested'),
  Chask.new(title: 'Balance the tires to prevent uneven wear', status: 'unrequested'),
  Chask.new(title: 'Inspect and replace worn-out or damaged suspension components', status: 'unrequested')
]

puts "Compleed seeding"
