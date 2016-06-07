class Task < ActiveRecord::Base
	has_one :assignment, dependent: :destroy
	has_one :project, through: :assignment
	has_one :user, through: :assignment

	accepts_nested_attributes_for :assignment

	validates :name, :finishing_date, presence: true

	alias_attribute :title, :name
	alias_attribute :deadline, :finishing_date
end
