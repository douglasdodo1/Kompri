require "rails_helper"

RSpec.describe Produto, type: :model do
  describe "estrutura do banco de dados" do
    let(:columns) { Produto.columns_hash }

    it "possui a coluna nome como string e não nula" do
      column = columns["nome"]
      expect(column.type).to eq(:string)
      expect(column.null).to be_falsey
    end

    it "possui a coluna marca como string" do
      column = columns["marca"]
      expect(column.type).to eq(:string)
    end

    it "possui a coluna categoria como string" do
      column = columns["categoria"]
      expect(column.type).to eq(:string)
    end
  end
end