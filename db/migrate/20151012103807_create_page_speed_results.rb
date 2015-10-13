class CreatePageSpeedResults < ActiveRecord::Migration
  def change
    create_table :page_speed_results do |t|
      t.integer :project_id
      t.string :address
      t.string :strategy
      t.jsonb :rule_groups
      t.jsonb :stats
      t.jsonb :insights
      t.jsonb :problems

      t.timestamps
    end
  end
end
