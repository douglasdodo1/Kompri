class CreateInstituicoes < ActiveRecord::Migration[8.0]
  def change
    create_table :instituicoes do |t|
      t.string :nome, null: false

      t.timestamps
    end
  end
end
