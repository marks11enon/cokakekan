class CreateDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :details do |t|
      t.integer :user_id
      t.integer :month_id
      t.integer :category_id
      t.integer :income
      t.integer :spending
      t.text :note
      t.integer :player
      t.boolean :status
      t.date :date

      t.timestamps
    end
  end
end
