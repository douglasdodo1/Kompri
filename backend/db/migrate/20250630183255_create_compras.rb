class CreateCompras < ActiveRecord::Migration[8.0]
  def change
    create_table :compras do |t|
      t.string :status, null: false, default: "pendente"
      t.references :usuario, null: false, foreign_key: true
      t.references :instituicao, null: false, foreign_key: true
      t.decimal :valor_total, null: false, precision: 10, scale: 2
      t.decimal :valor_estimado, null: false, precision: 10, scale: 2
      t.integer :qtd_itens, null: false

      t.timestamps
    end
  end
end
