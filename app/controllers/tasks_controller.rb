class TasksController < ApplicationController

  def index
    @tasks = policy_scope(Task).all
  end

  def show
    @task = Task.find(params[:id])
    authorize @task
  end

  def update
    @task = Task.find(params[:id])
    authorize @task
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    authorize @task

    if @task.save
      task_prompt = @task.title
      # API Call
      chask_array = chat_get(task_prompt)
      chask_array.each do |title|
        chask = Chask.new(title: title, task: @task)
        if chask.save
          @chask = chask
        else
          raise
        end
      end
      authorize @chask
      next_chask(@task, @chask)
    else
      render 'pages/home'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    authorize @task

    # Destroy logic...
  end

  private

  def task_params
    params.require(:task).permit(:title)
  end

  def chat_get(prompt)
    # method to call openAI API
    divider = 'nex2'
    ammount = 5
    adapted_prompt = "I want a list of '#{ammount}' sub-tasks (maximum 10 words per item) for the task of #{prompt}. Split each sub-task with a divider '#{divider}', return in simple text format"
    response = OpenaiService.new(adapted_prompt).call
    adapted_response = response.split(divider)
    return adapted_response
    # return an array
    # ['layer1test3', 'layer1test4', 'layer1tell uncle']
  end

  def next_chask(task, chask)
    # Checks if there is a next sub_chask, if there is a next chask
    next_chask = task.chasks.find_by(status: 'pending')
    if next_chask
      return redirect_to chask_path(next_chask), notice: 'Chask Completed, Next Chask'
    else
      task.completed = true
      return redirect_to tasks_path
    end
  end
end
