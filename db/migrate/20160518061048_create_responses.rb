class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses, id: :uuid do |table|
      table.uuid :order_id, null: false, index: true
      table.uuid :account_id, null: false, index: true
      table.integer :message, null: false, index: true

      table.timestamps null: false, index: true
    end
  end
end
