class CreateCompras < ActiveRecord::Migration[8.0]
  def change
    create_table :compras do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false
      t.references :instituicao, null: false, foreign_key: true
      t.decimal :valor_total, null:false, precision: 10, scale: 2
      t.decimal :valor_estimado, null:false, precision: 10, scale: 2
      t.integer :qtd_itens, null: false

      t.timestamps
    end
  end
end
