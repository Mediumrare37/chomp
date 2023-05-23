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

  def breakdown
    @chask = Chask.find(params[:id])
    chask_prompt = @chask.title
    # supposed to return an array of 5 sub_chasks
    sub_chask_array = chat_get(chask_prompt)
    chask_id = Chask.find(params[:id]).id
    sub_chask_array.each do |title|
      sub_chask = Chask.new(title: title, chask_id: chask_id)
      unless sub_chask.save
        redirect_to chask_path(@chask), notice: 'Sub Chask could not be created.'
      end
    end


    @next_sub_chask = Chask.where(chask_id: @chask.id).find_by(status: 'pending')
    redirect_to chask_path(@next_sub_chask), notice: 'Sub Chask created successfully.'
  end

  private

  def chask_params
    params.require(:chask).permit(:title, :status)
  end

  def chat_get(prompt)
    # method to call openAI API
    # return an array
    ['Check visa', 'Check industry', 'tell mom']
  end
end
