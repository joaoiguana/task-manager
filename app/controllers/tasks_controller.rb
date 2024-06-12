class TasksController < ApplicationController
  def index
    @pending_tasks = Task.get_by_status("Pending")
    @completed_tasks = Task.get_by_status("Completed")
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    @task.status = "Pending"
    @task.save
    @task.bucket.update_status
    redirect_to task_path(@task)
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    @bucket = @task.bucket.update_status
    redirect_to task_path(@task)
  end

  def destroy
    @task = Task.find(params[:id]).destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :status, :bucket_id)
  end
end
