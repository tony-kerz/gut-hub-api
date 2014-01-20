class CreateIngests < ActiveRecord::Migration
  def change
    create_table :ingests do |t|
      t.string :file_name
      t.datetime :file_at
      t.integer :records
      t.string :status
      t.boolean :success
      t.timestamps
    end
  end
end
