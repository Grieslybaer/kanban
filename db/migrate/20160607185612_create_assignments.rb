class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
    	t.integer :project_id, index: true
    	t.integer :task_id, index: true
    	t.integer :user_id, index: true
    	t.string :status, null: false
    	
      t.timestamps null: false
    end
  end
end
