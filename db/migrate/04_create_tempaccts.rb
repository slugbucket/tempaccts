class CreateTempaccts < ActiveRecord::Migration
  def change
    create_table :tempaccts, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :firstname, :limit => 20, :null => false
      t.string :surname, :limit => 20, :null => false
      t.string :uid, :null => false, :default => 'new_user', :limit => 32
      t.integer:account_type_id, :integer, :null => false, :default => 1
      t.string :passwd, :null => false, :limit => 16
      t.string :owner, :limit => 32, :null => false
      t.date :expiry_date, :null => false
      t.boolean :ftp_login, :default => false
      t.boolean :in_ldap, :default => false
      t.boolean :printing, :default => false
      t.text :description, :null => false

      t.timestamps
    end
  end
end
