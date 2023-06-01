class GenerateTaskJob < ApplicationJob
  queue_as :default

  def perform(task)
    task_hash = openai_call_api(task)
    task_hash.keys.each_with_index do |chask_title, index|
      chask = Chask.new(title: chask_title, task: task)
      chask.status = 'queued' if index.zero?
      if chask.save
        task_hash[chask_title].each do |subchask_title|
          subchask = Chask.new(title: subchask_title, chask: chask, task: task, status: 'unrequested')
          redirect_to root_path unless subchask.save
        end
      else
        redirect_to root_path
      end
    end
  end

  def openai_call_api(task)
    adapted_prompt = "The user gives you a task, return an ruby hash with 5 key-value pairs. Each key (maxium 8 words) is a sub-task of the user prompt. Each value (maximum 8 words) is an array of 3 sub-tasks for the sub-task in the corresponding key. Follow the forma in the example:

    'Find a job in software development'
    {'Update your resume and linkedin'=>['Add recent work experience and accomplishments','Highlight relevant skills and certifications','Optimize keywords for better visibility'],'Narrow down the criteria you are looking for in a job'=>['Identify your preferred software development roles and industries','Determine your desired location and work environment','Define the key factors for job satisfaction and career growth'],'Write a cover letter'=>['Research the company and position you are applying for','Customize the cover letter to highlight your relevant skills and experiences','Proofread for grammar and spelling errors'],'Get involved in professional industry networks'=>['Join software development communities and online forums','Attend industry conferences and networking events','Participate in open-source projects or coding challenges'],'Practice for technical interviews'=>['Solve coding problems and algorithms on coding platforms','Practice explaining your past projects and technical experiences','Conduct mock interviews with friends or mentors']}

    Prompt: #{task.title}"
    response = OpenaiService.new(adapted_prompt).call
    return eval(response)
  end
end
