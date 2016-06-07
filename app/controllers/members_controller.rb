class MembersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_project
  before_action :authorize_project_owner, only: [:create, :update, :destroy]
  before_action :set_member, only: [:update, :destroy]
  before_action :set_index_values, only: [:index]
  
  def index
    authorize! :read, @project
    @member = @project.members.new
  end

  def create
    @member = @project.members.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to project_members_path(@project), notice: 'Member was successfully added.' }
        format.json { render action: 'index', status: :created, location: @member }
      else
        set_index_values
        format.html { render action: 'index' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to project_members_path(@project), notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        set_index_values
        format.html { render action: 'index' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to project_members_path(@project) }
      format.json { head :no_content }
    end
  end

  private

  def member_params
    params.require(:member).permit(:user_id, :user_role)
  end

  def set_member
    @member = @project.members.find(params[:id])
  end

  def set_project
    @project = Project.includes(:members).find(params[:project_id])
  end

  def set_index_values
    @project_user_ids = @project.users.pluck(:id)
    @users = User.all
    @members = @project.members.includes(:user)
    @roles = Member.roles
  end

  def authorize_project_owner
    authorize! :manage, @project
  end

end
