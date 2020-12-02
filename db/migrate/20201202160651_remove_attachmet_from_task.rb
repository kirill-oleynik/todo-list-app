class RemoveAttachmetFromTask < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :attachmet, :string
  end
end
