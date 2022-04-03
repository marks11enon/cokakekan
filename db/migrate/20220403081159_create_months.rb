class CreateMonths < ActiveRecord::Migration[6.1]
  def change
    create_table :months do |t|
      t.integer :user_id, null: false
      t.date :month
      t.integer :balance
      t.integer :balance_last

      t.timestamps
    end
  end
end
