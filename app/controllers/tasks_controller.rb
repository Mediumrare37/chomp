class TasksController < ApplicationController

  def index
    @task = Task.all
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
    authorize @task
  end

  def destroy
    @task = Task.find(params[:id])
    authorize @task

    # Destroy logic...
  end
end
