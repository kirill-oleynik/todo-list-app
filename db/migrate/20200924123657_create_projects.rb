class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
