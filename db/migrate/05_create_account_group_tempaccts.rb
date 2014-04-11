class CreateAccountGroupTempaccts < ActiveRecord::Migration
  def change
    create_table :account_group_tempaccts, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :acct_group_id
      t.integer :tempacct_id

      t.timestamps
    end
  end
end
