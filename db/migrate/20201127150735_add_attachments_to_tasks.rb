class AddAttachmentsToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :attachment, :string
  end
end
