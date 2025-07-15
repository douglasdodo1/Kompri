require "rails_helper"

RSpec.describe Instituicao, type: :model do
  describe "estrutura do banco de dados" do
    let(:columns) { Instituicao.columns_hash }
    it "possui a coluna nome como string e não nula" do
      column = columns["nome"]
      expect(column.type).to eq(:string)
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