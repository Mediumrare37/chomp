class ChasksController < ApplicationController
  def show
    # Line below is to create a sub-chask
    # @chask = Chask.new
    @chask = Chask.find(params[:id])
    # if params[:filter]
  end

  def edit
    @chask = Chask.find(params[:id])
    @task = @chask.task
  end

  def update
    @chask = Chask.find(params[:id])
    @task = @chask.task

    if @chask.update(chask_params)
      redirect_to chask_path(@chask), notice: 'Chask was successfully updated.'
    else
      render :edit
    end
  end

  def progress
    #inject HTML or create partial for progress view
    @chask = Chask.find(params[:id])
    @task = @chask.task

    if @chask.update(chask_params)
      next_chask(@task, @chask)
    else
      render :show
    end
  end

  def queued
    #inject HTML or create partial for progress view
    @chask = Chask.find(params[:id])
    @task = @chask.task

    if @chask.update(chask_params)
      next_chask(@task, @chask)
    else
      render :show
    end
  end

  def excluded
    @chask = Chask.find(params[:id])
    @task = @chask.task

    if @chask.update(chask_params)
      next_chask(@task, @chask)
    else
      render :show
    end
  end

  def breakdown
    @chask = Chask.find(params[:id])
    @task = @chask.task
    # Task is in progress since it was broken down
    @chask.status = 'progress'
    @chask.save
    chask_prompt = @chask.title

    sub_chask_array = chat_get(chask_prompt)
    sub_chask_array.each do |sub_title|
      sub_chask = Chask.new(title: sub_title, chask: @chask, task: @chask.task)
      if sub_chask.save
        # Controller sub chask simply passes any subchask to the method so it works
        @controler_sub_chask = sub_chask
      else
        raise
      end
    end
      # need alternative condition if subtask doe snot save
      # redirect_to chask_path(@chask), notice: 'Sub Chask could not be created.'

    next_chask(@task, @controler_sub_chask)
  end

  private

  def chask_params
    params.require(:chask).permit(:title, :status)
  end

  def chat_get(prompt)
    prompt = ''
    # method to call openAI API
    # return an array
    ['test3', 'test4', 'tell uncle']
  end

  def next_chask(task, chask)
    # Checks if there is a next sub_chask, if there is a next chask
    next_chask = task.chasks.find_by(status: 'pending')
    next_sub_chask = Chask.where(chask_id: chask.chask_id).find_by(status: 'pending')
    if next_sub_chask
      return redirect_to chask_path(next_sub_chask), notice: 'Next Sub_Chask'
      # If no next_sub_chask need to find a way to change status of Chask
    elsif next_chask
      # Unsure if the status change can occur here
      next_chask.status = 'completed'
      return redirect_to chask_path(next_chask), notice: 'All Sub_Chasks Completed, Next Chask'
    else
      return redirect_to tasks_path
    end
  end
end
