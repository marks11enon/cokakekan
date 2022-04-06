class AddStatusToDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :details, :status, :boolean, default: true
  end
end
