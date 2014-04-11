class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## We're not using
      ## Database authenticatable
      t.string :username,          :null => false
      ## We don't need to store the pasword 
      ## t.string :encrypted_password, :null => false, :default => ""

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # rememberable
      t.datetime :remember_created_at

      t.timestamps
    end

    add_index :users, :username,                :unique => true
  end
end
