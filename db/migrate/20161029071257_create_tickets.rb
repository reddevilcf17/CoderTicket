class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.references :user, foreign_key: true
      t.integer :total_amount
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
