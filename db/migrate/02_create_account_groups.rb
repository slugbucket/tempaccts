class CreateAccountGroups < ActiveRecord::Migration
  def change
    create_table :account_groups, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :limit => 32, :default => 'Group name'
      t.text :description
      t.date :default_expiry

      t.timestamps
    end
  end
end
