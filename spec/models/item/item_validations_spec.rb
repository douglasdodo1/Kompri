require "rails_helper"

RSpec.describe Item, type: :model do
  describe "Validação de Itens" do
    it "é válido com atributos válidos" do
      expect(build(:item)).to be_valid
    end

    it "é inválido sem compra_id" do
      expect(build(:item, compra_id: nil)).not_to be_valid
    end

    it "é inválido sem produto_id" do
      expect(build(:item, produto_id: nil)).not_to be_valid
    end

    it "é inválido sem quantidade" do
      expect(build(:item, quantidade: nil)).not_to be_valid
    end

    it "é inválido com quantidade negativa" do
      expect(build(:item, quantidade: -1)).not_to be_valid
    end

    it "é inválido sem valor" do
      expect(build(:item, valor: nil)).not_to be_valid
    end

    it "é inválido com valor negativo" do
      expect(build(:item, valor: -1.0)).not_to be_valid
    end

  end
end