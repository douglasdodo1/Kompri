class CreateUsuarios < ActiveRecord::Migration[8.0]
  def change
    create_table :usuarios, id: false do |t|
      t.string :cpf, null: false, primary_key: true
      t.string :nome, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :telefone, null: false

      t.timestamps
    end

    add_index :usuarios, :email, unique: true
  end
end
