class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks if logged_in?
  end
  
  def show
   @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを投稿しました。"
      redirect_to @task
    else
      flash.now[:danger] = "タスクの投稿に失敗しました。"
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "タスクを編集しました。"
      redirect_to @task
    else
      flash.now[:danger] = "タスクの編集に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
