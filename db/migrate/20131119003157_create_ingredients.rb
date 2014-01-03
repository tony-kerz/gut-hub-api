class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.decimal :amount
      t.string :uom
      t.string :name
      t.integer :recipe_id

      t.timestamps
    end
  end
end
