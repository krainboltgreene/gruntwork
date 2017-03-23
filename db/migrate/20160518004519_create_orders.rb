class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders, id: :uuid do |table|
      table.text :description, null: false
      table.uuid :requester_id, index: true
      table.uuid :owner_id, index: true
      table.string :state, null: false, index: true
      table.integer :subtype, default: 0, null: false, index: true
      table.integer :priority, default: 0, null: false, index: true
      table.datetime :finished_at, index: true
      table.datetime :canceled_at, index: true

      table.timestamps null: false, index: true
    end
  end
end
