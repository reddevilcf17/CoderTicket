class CreateTicketDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :ticket_details do |t|
      t.belongs_to :ticket, foreign_key: true
      t.references :ticket_type, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
