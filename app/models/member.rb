class Member < ActiveRecord::Base
	belongs_to :project
	belongs_to :user

	@@roles = %w(admin dev)
	cattr_reader :roles
	
	validates :user, :project, :user_role, presence: true
	validates :user_role, inclusion: { in: @@roles }

	alias_attribute :role, :user_role
end
