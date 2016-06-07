class Project < ActiveRecord::Base
	has_many :members, dependent: :destroy
	has_many :users, through: :members

	has_many :administrators, -> { where user_role: 'admin' }, class_name: Member.to_s
	has_many :owners, through: :administrators, source: :user

	has_many :assignments, dependent: :destroy
	has_many :tasks, through: :assignments, dependent: :destroy

  validates :name, :finishing_date, presence: true

	alias_attribute :title, :name
	alias_attribute :deadline, :finishing_date
end
