require "rails_helper"

RSpec.describe Usuario, type: :model do
  describe "Validade de Usuarios" do
    it "é válido com atributos válidos" do
      expect(build(:usuario)).to be_valid
    end

    it "é inválido com nome vazio" do
      expect(build(:usuario, :nome_vazio)).not_to be_valid
    end

    it "é inválido com nome menor que 3 caracteres" do
      expect(build(:usuario, :nome_curto)).not_to be_valid
    end

    it "é inválido com nome maior que 100 caracteres" do
      expect(build(:usuario, :nome_grande)).not_to be_valid
    end

    it "é inválido com email vazio" do
      expect(build(:usuario, :email_vazio)).not_to be_valid
    end
    /
    it "é inválido com email sem @" do
      expect(build(:usuario, :email_sem_arroba)).not_to be_valid
    end

    it "é inválido com email sem ponto" do
      expect(build(:usuario, :email_sem_ponto)).not_to be_valid
    end
    /

    it "é inválido com senha vazia" do
      expect(build(:usuario, :password_vazio)).not_to be_valid
    end
  end
end
