class ChasksController < ApplicationController
  def show
    # Navbar display
    @show_navbar = true

    # Chask Show
    @chask = Chask.find(params[:id])
    @task = @chask.task
    @user = @task.user
    authorize @chask

    # Messages Show
    @message = Message.new
    authorize @message
    # authorize @task
  end

  def new
    @chask = Chask.new
    @task = Task.find(params[:task_id])
    authorize @chask
    authorize @task
  end

  def create
    @chask = Chask.new(chask_params)
    @task = Task.find(params[:task_id])
    @chask.status = 'queued'
    @chask.task = @task
    authorize @chask

    if @chask.save
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def edit
    @show_navbar = true
    @chask = Chask.find(params[:id])
    @task = @chask.task
    authorize @chask
    authorize @task
  end

  def update
    @chask = Chask.find(params[:id])
    @task = @chask.task
    authorize @chask
    authorize @task

    if @chask.update(chask_params)
      if @chask.pending? || @chask.paused?
        redirect_to chask_path(@chask)
      else
        redirect_to task_path(@task)
      end
    else
      render :edit
    end

    authorize @chask
  end

  def destroy
    @chask = Chask.find(params[:id]) # Find the @chask
    @task = @chask.task
    authorize @chask
    authorize @task

    @chask.destroy
    redirect_to task_path(@task)
  end

  def deadline
    @chask = Chask.find(params[:id]) # Find the @chask object first
    @task = @chask.task

    # Authorize the found @chask object
    authorize @chask
    authorize @task

      # Compares Chask deadline with task deadline, should be >=0
    if @task.deadline
      redirect_to chask_path(@chask), notice: 'Chask deadline MAXIMUM Task deadline' if (@task.deadline - @chask.deadline < 0)
    else
      @chask.update(chask_params)
      redirect_to chask_path(@chask), notice: 'Chask deadline updated'
    end
  end

  def global_deadline
    @chask = Chask.find(params[:id]) # Find the @chask object first
    @task = @chask.task

    # Authorize the found @chask object
    authorize @chask
    authorize @task

      # Compares Chask deadline with task deadline, should be >=0
    if @task.deadline
      redirect_to task_path(@task), notice: 'Chask deadline MAXIMUM Task deadline' if (@task.deadline - @chask.deadline < 0)
    else
      @chask.update(chask_params)
      redirect_to task_path(@task), notice: 'Chask deadline updated'
    end
  end

  def paused
    #inject HTML or create partial for progress view
    @chask = Chask.find(params[:id])
    @task = @chask.task

    authorize @chask
    authorize @task

    if @chask.update(chask_params)
      redirect_to chask_path(@chask), notice: 'Chask PAUSED'
    else
      render :show
    end
  end

  def completed
    #inject HTML or create partial for progress view
    @chask = Chask.find(params[:id])
    @task = @chask.task
    @user = @task.user
    # @end_time = Time.now

    authorize @chask
    authorize @task

    if @chask.update(chask_params)
      @chask.chask_id ? @user.complete_subchask : @user.complete_chask
      @chask.chask_id ? @user.complete_subchask_same_day_bonus : @user.complete_chask_same_day_bonus
      @chask.chasks.update_all(status: "completed")
      @user.save
      next_chask(@task)
    else
      render :show
    end
  end

  def progress
    #inject HTML or create partial for progress view
    @chask = Chask.find(params[:id])
    @task = @chask.task
    @user = @task.user
    @start_time = Time.now

    authorize @chask
    authorize @task

    if @chask.update(chask_params)
      # need to add condition for chask not started before
      @user.start_chask
      @user.save
      redirect_to chask_path(@chask), notice: 'Chask STARTED'
      # next_chask(@task, @chask)
      # no need to go to next chask for this
    else
      render :show
    end
  end

  def queued
    #inject HTML or create partial for progress view
    @chask = Chask.find(params[:id])
    @task = @chask.task

    authorize @chask
    authorize @task

    if @chask.update(chask_params)
      next_chask(@task)
    else
      render :show
    end
  end

  def excluded
    @chask = Chask.find(params[:id])
    @task = @chask.task

    authorize @chask
    authorize @task

    if @chask.update(chask_params)
      next_chask(@task)
    else
      render :show
    end
  end

  def breakdown
    @chask = Chask.find(params[:id])
    @task = @chask.task
    @user = @task.user
    authorize @chask
    authorize @task

    # Task is in progress since it was broken down
    @chask.status = 'progress'
    @chask.save

    # Change status of relevant subchasks from unrequested to pending
    @task.chasks.where(chask_id: @chask.id).each do |subchask|
      subchask.status = 'pending'
      subchask.save
    end

    # Points update
    @user.break_down_bonus
    @user.save
    next_chask(@task)
  end

  private

  def chask_params
    params.require(:chask).permit(:title, :status, :deadline)
  end

  def chat_get_reply(user_prompt)
    response = OpenaiService.new(user_prompt).call
    return response
  end

  #to add excluded
  def overall_progress_percentage(task)
    total_chasks = task.chasks.count
    completed_excluded_chasks = task.chasks.where(status: ["completed", "excluded"]).count

    overall_percentage = (completed_excluded_chasks.to_f / total_chasks.to_f) * 100
    overall_percentage.round(2)
  end

  def next_chask(task)
    next_chask = task.chasks.where(chask_id: nil).find_by(status: 'pending')
    next_subchask = task.chasks.where.not(chask_id: nil).find_by(status: 'pending')
    if next_subchask
      redirect_to chask_path(next_subchask)
    elsif next_chask
      redirect_to chask_path(next_chask)
    else
      task.completed = true
      redirect_to tasks_path
    end
  end

  # def chat_get(prompt)
  #   # method to call openAI API
  #   divider = 'nex2'
  #   ammount = 3
  #   adapted_prompt = "I want a list of '#{ammount}' sub-tasks (maximum 10 words per item) for the task of #{prompt}. Split each sub-task with a divider '#{divider}', return in simple text format"
  #   response = OpenaiService.new(adapted_prompt).call
  #   response = response.split(divider)
  #   return response
  #   # return an array
  #   # ['test3', 'test4', 'tell uncle']

  # def next_chask(task, chask)
  #   # There is a problem with the logic here
  #   # When the user creates a new task and goes through some of the chasks, the code will sometimes redirect the user to another task flow.
  #   # For example, when a new task is created, chask_id is nil unless the user decides to break it down, but by the default, chask_id is nil
  #   next_sub_chask = Chask.where(chask_id: chask.chask_id, status: 'pending').first
  #   # When the code above runs, it'll return an array containing every chask instance where chask_id is nil.
  #   # To sum it up, it's selecting not only the chasks for that specific task, but instead, every single instance of chask where chask_id = nil.

  #   if next_sub_chask
  #     redirect_to chask_path(next_sub_chask), notice: 'Next Sub_Chask'
  #   else
  #     next_chask = task.chasks.find_by(status: 'pending')

  #     if next_chask
  #       next_chask.update(status: 'completed') # Mark the next task as completed
  #       redirect_to chask_path(next_chask), notice: 'All Sub_Chasks Completed, Next Chask'
  #     else
  #       task.update(completed: true) # Mark the task as completed
  #       redirect_to tasks_path, notice: 'All Tasks Completed' # Redirect to tasks/index.html.erb
  #     end
  #   end
  # end
end
