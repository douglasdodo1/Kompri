require "rails_helper"

RSpec.describe Instituicao, type: :model do
  describe "estrutura do banco de dados" do
    let(:columns) { Instituicao.columns_hash }
    it "possui a coluna nome como string e não nula" do
      column = columns["nome"]
      expect(column.type).to eq(:string)
    end
  end
end