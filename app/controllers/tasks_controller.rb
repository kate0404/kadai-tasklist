class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
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
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = "タスクを編集しました。"
      redirect_to @task
    else
      flash.now[:danger] = "タスクの編集に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private
  
  def task_params
    params.require(:task).permit(:content)
  end
end
