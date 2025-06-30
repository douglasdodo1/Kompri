class CreateInstituicoes < ActiveRecord::Migration[8.0]
  def change
    create_table :instituicoes do |t|
      t.string :nome

      t.timestamps
    end
  end
end
