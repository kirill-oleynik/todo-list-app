class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :title, null: false
      t.boolean :done, null: false, default: false
      t.references :project, null:false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
