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

  def excluded
    @chask = Chask.find(params[:id])
    @task = @chask.task

    if @chask.update(chask_params)
      @next_chask = @task.chasks.find_by(status: 'pending')
      if @next_chask
        redirect_to chask_path(@next_chask), notice: 'Chask was successfully updated.'
      else
        redirect_to tasks_path
      end
    else
      render :show
    end
  end

  private

  def chask_params
    params.require(:chask).permit(:title, :status)
  end
end
