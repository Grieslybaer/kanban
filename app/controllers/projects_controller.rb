class ProjectsController < ApplicationController
	before_filter :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authorize_project_owner, only: [:edit, :update, :destroy]

  def index
    @projects = current_user.projects.all
  end

  def show
    authorize! :read, @project
    @assignments = Assignment.includes(:task, :user).where(project_id: params[:id]).group_by(&:status)
    @owner = @project.owners.first
    @states = Assignment.states
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        @project.members.create!(user: current_user, user_role: 'admin')
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path }
      format.json { head :no_content }
    end
  end

  private
  def set_project
    @project = Project.includes(:users).find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :deadline)
  end

  def authorize_project_owner
    authorize! :manage, @project
  end
end
