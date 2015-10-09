class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :admin_id
      t.string :project_name
      t.timestamps
    end
  end
end
