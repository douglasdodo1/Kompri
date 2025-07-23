require "rails_helper"

RSpec.describe Item, type: :model do
  describe "estrutura do banco de dados" do
    let(:columns) { Item.columns_hash }

    it "possui a coluna compra_id como integer e não nula" do
      column = columns["compra_id"]
      expect(column.type).to eq(:integer)
      expect(column.null).to be false
    end

    it "possui a coluna produto_id como integer e não nula" do
      column = columns["produto_id"]
      expect(column.type).to eq(:integer)
      expect(column.null).to be false
    end

    it "possui a coluna quantidade como integer e não nula" do
      column = columns["quantidade"]
      expect(column.type).to eq(:integer)
      expect(column.null).to be false
    end

    it "possui a coluna valor como decimal com precisão 10 e escala 2 e não nula" do
      column = columns["valor"]
      expect(column.type).to eq(:decimal)
      expect(column.precision).to eq(10)
      expect(column.scale).to eq(2)
      expect(column.null).to be false
    end

    it "possui a coluna comprado como boolean e não nula" do
      column = columns["comprado"]
      expect(column.type).to eq(:boolean)
      expect(column.null).to be false
      expect(column.default).to eq("false")
    end

    it "possui a coluna created_at como datetime e não nula" do
      column = columns["created_at"]
      expect(column.type).to eq(:datetime)
      expect(column.null).to be false
    end

    it "possui a coluna updated_at como datetime e não nula" do
      column = columns["updated_at"]
      expect(column.type).to eq(:datetime)
      expect(column.null).to be false
    end 
  end


end