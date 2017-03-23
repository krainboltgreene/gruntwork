class DeviseCreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, id: :uuid do |table|
      table.string :email, null: false, index: {unique: true}
      table.string :encrypted_password, null: false
      table.string :reset_password_token, index: true
      table.datetime :reset_password_sent_at
      table.datetime :remember_created_at
      table.integer  :sign_in_count, default: 0, null: false
      table.datetime :current_sign_in_at
      table.datetime :last_sign_in_at
      table.inet :current_sign_in_ip
      table.inet :last_sign_in_ip
      table.string :confirmation_token, index: true
      table.datetime :confirmed_at
      table.datetime :confirmation_sent_at
      table.string :unconfirmed_email, index: true
      table.boolean :watching, default: false, null: false

      table.timestamps null: false, index: true
    end
  end
end
