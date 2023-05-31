class TasksController < ApplicationController

#We have an issue with the home page loading to the created methd below.

  def index
    @tasks = policy_scope(Task).all
  end

  def show
    @task = Task.find(params[:id])
    @chasks = @task.chasks
    authorize @task
  end

  def update
    @task = Task.find(params[:id])
    authorize @task
  end

  #This method will be called from Tasks dashboard

  def deadline
    @task = Task.find(params[:id])
    @chask = @task.chasks

    # Authorize the found @chask object
    authorize @chask
    authorize @task

    # Compares Task deadline with Chask deadline, should be >= 0
    if @chask.deadline
      redirect_to chask_path(@chask), notice: 'Chask deadline MAXIMUM Task deadline' if (@task.deadline - @chask.deadline < 0)
    else
      @chask.update(chask_params)
      redirect_to chask_path(@chask), notice: 'Chask deadline updated'
    end
  end

#updated the create with the API call

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    @user = @task.user
    authorize @task

    if @task.save
      # API Call
      task_hash = @task.openai_call_api
      task_hash.keys.each do |chask_title|
        chask = Chask.new(title: chask_title, task: @task)
        if chask.save
          task_hash[chask_title].each do |subchask_title|
            subchask = Chask.new(title: subchask_title, chask: chask, task: @task, status: 'unrequested')
            redirect_to root_path unless subchask.save
          end
        else
          redirect_to root_path
        end
      end

      # Points
      @user.create_task
      @user.save

      # Send notification to LINE account
      line_service = LineService.new
      message = 'A new task has been created!'
      destination = 'U909af1996750d210edbc91f0a1fa2e1e' # Replace with the actual destination user ID
      line_service.send_message(message, destination)

      # Move to start displaying flow
      next_chask(@task)
    else
      redirect_to root_path
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

  def next_chask(task)
    next_chask = task.chasks.where(chask_id: nil).find_by(status: 'pending')
    next_subchask = task.chasks.where.not(chask_id: nil).find_by(status: 'pending')
    if next_subchask
      redirect_to chask_path(next_sub_chask)
    elsif next_chask
      redirect_to chask_path(next_chask)
    else
      task.completed = true
      redirect_to tasks_path
    end
  end
end
