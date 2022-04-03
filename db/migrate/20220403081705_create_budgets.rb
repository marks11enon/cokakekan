class CreateBudgets < ActiveRecord::Migration[6.1]
  def change
    create_table :budgets do |t|
      t.integer :user_id, null: false
      t.integer :month_id, null: false
      t.integer :amount

      t.timestamps
    end
  end
end
