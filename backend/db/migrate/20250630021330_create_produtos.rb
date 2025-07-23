class CreateProdutos < ActiveRecord::Migration[8.0]
  def change
    create_table :produtos do |t|
      t.string :nome, null: false
      t.string :marca
      t.string :categoria

      t.timestamps
    end
  end
end
