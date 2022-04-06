class RemoveStatusFromDetails < ActiveRecord::Migration[6.1]
  def change
    remove_column :details, :status, :boolean
  end
end
