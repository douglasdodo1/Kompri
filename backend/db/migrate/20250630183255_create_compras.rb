class CreateCompras < ActiveRecord::Migration[8.0]
  def change
    create_table :compras do |t|
      t.string :usuario_cpf, null: false
      t.string :status, null: false, default: "pendente"
      t.references :instituicao, null: false, foreign_key: true
      t.decimal :valor_total, null:false, precision: 10, scale: 2
      t.decimal :valor_estimado, null:false, precision: 10, scale: 2
      t.integer :qtd_itens, null: false

      t.timestamps
    end

    add_foreign_key :compras, :usuarios, column: :usuario_cpf, primary_key: :cpf
  end
end
