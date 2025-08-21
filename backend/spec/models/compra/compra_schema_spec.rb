require "rails_helper"

RSpec.describe Compra, type: :model do
  describe "estrutura do banco de dados" do
    let(:columns) { Compra.columns_hash }
    it "possui a coluna id como integer e não nula" do
      column = columns["id"]
      expect(column.type).to eq(:integer)
      expect(column.null).to be_falsey
    end

    it "possui a coluna status como string e não nula" do
      column = columns["status"]
      expect(column.type).to eq(:string)
      expect(column.null).to be_falsey
    end

    it "possui a coluna instituicao_id como integer e não nula" do
      column = columns["instituicao_id"]
      expect(column.type).to eq(:integer)
      expect(column.null).to be_falsey
    end

    it "possui a coluna valor_total como decimal com precisão 10 e escala 2 e não nula" do
      column = columns["valor_total"]
      expect(column.type).to eq(:decimal)
      expect(column.precision).to eq(10)
      expect(column.scale).to eq(2)
      expect(column.null).to be_falsey
    end

    it "possui a coluna valor_estimado como decimal com precisão 10 e escala 2 e não nula" do
      column = columns["valor_estimado"]
      expect(column.type).to eq(:decimal)
      expect(column.precision).to eq(10)
      expect(column.scale).to eq(2)
      expect(column.null).to be_falsey
    end

    it "possui a coluna qtd_itens como integer e não nula" do
      column = columns["qtd_itens"]
      expect(column.type).to eq(:integer)
      expect(column.null).to be_falsey
    end

    it "possui a coluna created_at como datetime e não nula" do
      column = columns["created_at"]
      expect(column.type).to eq(:datetime)
      expect(column.null).to be_falsey
    end

    it "possui a coluna updated_at como datetime e não nula" do
      column = columns["updated_at"]
      expect(column.type).to eq(:datetime)
      expect(column.null).to be_falsey
    end
  end
end