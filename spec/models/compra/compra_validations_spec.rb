require "rails_helper"

RSpec.describe Produto, type: :model do
  describe "Validação de Produtos" do
    it "é válido com atributos válidos" do
      expect(build(:compra)).to be_valid
    end

    it "é inválido com CPF vazio" do
      expect(build(:compra, :usuario_cpf_vazio)).not_to be_valid
    end

    it "é inválido com status vazio" do
      expect(build(:compra, :status_vazio)).not_to be_valid
    end

    it "é inválido com status inválido" do
      expect(build(:compra, :status_invalido)).not_to be_valid
    end

    it "é inválido com valor_total vazio" do
      expect(build(:compra, :valor_total_vazio)).not_to be_valid
    end

    it "é inválido com valor_total negativo" do
      expect(build(:compra, :valor_total_negativo)).not_to be_valid
    end

    it "é inválido com valor_estimado vazio" do
      expect(build(:compra, :valor_estimado_vazio)).not_to be_valid
    end

    it "é inválido com valor_estimado negativo" do
      expect(build(:compra, :valor_estimado_negativo)).not_to be_valid
    end

    it "é inválido com qtd_itens vazio" do
      expect(build(:compra, :qtd_itens_vazio)).not_to be_valid
    end

    it "é inválido com qtd_itens negativo" do
      expect(build(:compra, :qtd_itens_negativo)).not_to be_valid
    end
  end
end
