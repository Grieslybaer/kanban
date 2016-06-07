class AssignmentsController < ApplicationController
	before_filter :authenticate_user!

	def update
		@assignment = Assignment.find(params[:id])
    authorize! :update, @assignment
		@project = @assignment.project
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to project_path(@project), notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def assignment_params
    params.require(:assignment).permit(:status)
  end
end
