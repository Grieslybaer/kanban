class Assignment < ActiveRecord::Base
	belongs_to :project
	belongs_to :task
	belongs_to :user

	@@states = ["backlog", "todo", "in progress", "code review", "done"]
	cattr_reader :states

	validates :project, :task, presence: true
  validates :user, presence: true, on: :update
	validates :status, inclusion: { in: @@states }, on: :update

	before_create :set_status

	private
	def set_status
		self.status = @@states.first
	end
end
