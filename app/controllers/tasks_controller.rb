class TasksController < ApplicationController

#We have an issue with the home page loading to the created methd below.
  def index
    # Index method has changed, from now on we display our task flows selectively in the following pattern: 3 task flows according to user criteria + all completed task flows
    @tasks = policy_scope(Task).all
    filter = params[:filter]

    case filter
    when 'recent'
      @label = 'Recently modified'
      @filtered_tasks = @tasks.order(updated_at: :desc).first(3)
    when 'old'
      @label = 'Forgotten Flows'
      @filtered_tasks = @tasks.order(updated_at: :asc).first(3)
    when 'most_urgent'
      @label = 'Most Urgent'
      @filtered_tasks = @tasks.where.not(deadline: nil).order(deadline: :asc).first(3)
      # If no tasks with deadline, reverte to "new"
      # @filtered_tasks = @tasks.order(updated_at: :desc).first(3) if @filtered_tasks_gate.empty?
    when 'least_urgent'
      @label = 'Least Urgent'
      @filtered_tasks = @tasks.where.not(deadline: nil).order(deadline: :desc).first(3)
      # # If no tasks with deadline, reverte to "old"
      # @filtered_tasks = @tasks.order(updated_at: :asc).first(3) if @filtered_tasks_gate.empty?
    when 'most_progress'
      @label = 'Most Progress'
      # This method goes through all the tasks to get the 3 with the highest completion percentages
      most_progress(@tasks)
    when 'least_progress'
      @label = 'Least Progress'
      # Same method as above but with lowest comlpletion
      least_progress(@tasks)
    else
      @label = 'Dashboard View'
      @sublabel = ['Upcoming Deadline', 'Almost Done', 'Revisit a forgotten task']
      # Dashboard view displays if no filter and by default:
      @filtered_gate = []
      # Task with upcoming deadline or recently touched task
      @deadline_gate = @tasks.where.not(deadline: nil).order(deadline: :asc).first
      @recent_gate = @tasks.order(updated_at: :desc).first
      if @deadline_gate.nil?
        @filtered_gate << @recent_gate
      else
        @filtered_gate << @deadline_gate
      end
      # Finish a task that is almost completed!
      @filtered_gate << most_progress(@tasks).first
      # Get back to a task you haven't touched in a while
      @old_gate = @tasks.order(updated_at: :asc).first
      @filtered_gate << @old_gate
      @filtered_tasks = @filtered_gate
    end
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
    @task.destroy
    redirect_to tasks_path
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

  def most_progress(tasks)
    # This method goes through all the tasks to get the 3 with the highest completion percentages
    most_progress = {}
    tasks.each do |task|
      most_progress.store(task.id, task.complete_percentage) if task.complete_percentage != 100
    end
    most_ids = most_progress.max_by(3) { |k, v| v }
    @filtered_tasks = @tasks.where(id: [most_ids[0][0], most_ids[1][0], most_ids[2][0]])
  end

  def least_progress(tasks)
    least_progress = {}
    tasks.each do |task|
      least_progress.store(task.id, task.complete_percentage)
    end
    least_ids = least_progress.min_by(3) { |k, v| v }
    @filtered_tasks = @tasks.where(id: [least_ids[0][0], least_ids[1][0], least_ids[2][0]])
  end
end
