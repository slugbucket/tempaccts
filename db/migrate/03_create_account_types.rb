class CreateAccountTypes < ActiveRecord::Migration
  def change
    create_table :account_types, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :limit => 64, :null => false
      t.text :description
      t.date :max_expiry

      t.timestamps
    end
  end
end
