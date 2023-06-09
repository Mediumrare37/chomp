require "json"

class Task < ApplicationRecord
  has_many :chasks, dependent: :destroy
  belongs_to :user
  has_many :notifications, as: :object
  validates :title, presence: true
  # validates :completed, presence: true

  def complete_percentage
    if (self.chasks.where.not(status: ['excluded', 'unrequested']).length) == 0
      return 0
    else
      completed = self.chasks.where(status: 'completed').length
      total = self.chasks.where.not(status: ['excluded', 'unrequested']).length
      return ((completed / total.to_f) * 100).round
    end
  end

  # Method checks if task is 100% completed and if so changes 'completed'
  def completed!
    if self.complete_percentage == 100
      self.completed = true
    else
      self.completed = false
    end
  end

  def openai_call_api
    adapted_prompt = "The user gives you a task, return an ruby hash with 5 key-value pairs. Each key (maxium 8 words) is a sub-task of the user prompt. Each value (maximum 8 words) is an array of 3 sub-tasks for the sub-task in the corresponding key. Follow the forma in the example:

    Prompt:'Find a job in software development'
    Response:{'Update your resume and linkedin'=>['Add recent work experience and accomplishments','Highlight relevant skills and certifications','Optimize keywords for better visibility'],'Narrow down the criteria you are looking for in a job'=>['Identify your preferred software development roles and industries','Determine your desired location and work environment','Define the key factors for job satisfaction and career growth'],'Write a cover letter'=>['Research the company and position you are applying for','Customize the cover letter to highlight your relevant skills and experiences','Proofread for grammar and spelling errors'],'Get involved in professional industry networks'=>['Join software development communities and online forums','Attend industry conferences and networking events','Participate in open-source projects or coding challenges'],'Practice for technical interviews'=>['Solve coding problems and algorithms on coding platforms','Practice explaining your past projects and technical experiences','Conduct mock interviews with friends or mentors']}

    Prompt: #{self.title}"
    response = OpenaiService.new(adapted_prompt).call
    response_clean = response.split('Response:')[1]
    return eval(response_clean)
  end
end
