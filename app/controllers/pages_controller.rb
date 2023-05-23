class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @task = Task.new
  end

  private

  def task_params
    params.require(:task).permit(:title)
  end

end
