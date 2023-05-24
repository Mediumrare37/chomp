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
      redirect_to tasks_path, notice: 'Task successfully created!'
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
end
