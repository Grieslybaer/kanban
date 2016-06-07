class TasksController < ApplicationController
	before_filter :authenticate_user!

  before_action :set_project
  before_action :authorize_project_member, only: [:index, :show]
  before_action :authorize_project_owner, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project_members, only: [:new, :edit]

  def index
    @tasks = @project.tasks.all
  end

  def show
  end

  def new
    @task = @project.tasks.new
  end

  def edit
  end

  def create
    @task = @project.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        @task.assignment.update(task_params[:assignment_attributes])
        format.html { redirect_to project_path(@project), notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        set_project_members
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:task][:assignment_attributes]
      @task.assignment.update(task_params[:assignment_attributes])
      params[:task].delete(:assignment_attributes)
    end

    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_path(@project), notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        set_project_members
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_url, notice: 'Task was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :finishing_date, :priority, assignment_attributes: [:user_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def set_project
    @project = Project.includes(:tasks, :users).find(params[:project_id])
  end

  def set_project_members
    @members = @project.users.all
  end

  def authorize_project_owner
    authorize! :manage, @project
  end

  def authorize_project_member
    authorize! :read, @project
  end
end
