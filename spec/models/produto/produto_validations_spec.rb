require "rails_helper"

RSpec.describe Produto, type: :model do
  describe "Validação de Produtos" do
    it "é válido com atributos válidos" do
      expect(build(:produto)).to be_valid
    end

    it "é inválido com nome vazio" do
      expect(build(:produto, :nome_vazio)).not_to be_valid
    end

    it "é inválido com nome menor que 3 caracteres" do
      expect(build(:produto, :nome_curto)).not_to be_valid
    end

    it "é inválido com nome maior que 100 caracteres" do
      expect(build(:produto, :nome_grande)).not_to be_valid
    end

    it "é inválido com marca maior que 100 caracteres" do
      expect(build(:produto, :marca_grande)).not_to be_valid
    end
  end
end