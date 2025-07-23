class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.references :compra, null: false, foreign_key: true
      t.references :produto, null: false, foreign_key: true
      t.integer :quantidade, null: false
      t.decimal :valor, precision: 10, scale: 2, null: false
      t.boolean :comprado, null: false, default: false

      t.timestamps
    end
  end
end
