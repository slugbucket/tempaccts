class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.string :item_type
      t.integer :item_id
      t.string :act_action
      t.string :updated_by
      t.text :activity
      t.datetime :act_tstamp
    end
  end
end
