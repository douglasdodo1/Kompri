require "rails_helper"

RSpec.describe Usuario, type: :model do
  describe "estrutura do banco de dados" do
    let(:columns) { Usuario.columns_hash }

    it "possui a coluna cpf como string e não nula" do
      column = columns["cpf"]
      expect(column.type).to eq(:string)
      expect(column.null).to be_falsey
    end

    it "possui a coluna nome como string e não nula" do
      column = columns["nome"]
      expect(column.type).to eq(:string)
      expect(column.null).to be_falsey
    end

    it "possui a coluna email como string e não nula" do
      column = columns["email"]
      expect(column.type).to eq(:string)
      expect(column.null).to be_falsey
    end

    it "possui índice único na coluna email" do
      indexes = ActiveRecord::Base.connection.indexes("usuarios")
      email_index = indexes.find { |i| i.columns == ["email"] }
      expect(email_index).not_to be_nil
      expect(email_index.unique).to be_truthy
    end

    it "possui a coluna password_digest como string e não nula" do
      column = columns["password_digest"]
      expect(column.type).to eq(:string)
      expect(column.null).to be_falsey
    end

    it "possui a coluna telefone como string e não nula" do
      column = columns["telefone"]
      expect(column.type).to eq(:string)
      expect(column.null).to be_falsey
    end
  end
end
