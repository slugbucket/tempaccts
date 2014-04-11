class CreateSchemaMigrations < ActiveRecord::Migration
  def change
    create_table :schema_migrations do |t|
      t.string :version, :limit => 64, :null => false
    end
  end
end
