require "rails_helper"

RSpec.describe Usuario, type: :model do
  describe "Validade de Usuarios" do
    it "é válido com atributos válidos" do
      expect(build(:usuario)).to be_valid
    end

    it "é inválido com cpf vazio" do
      expect(build(:usuario, :cpf_vazio)).not_to be_valid
    end

    it "é inválido com cpf com caractere não válido" do
      expect(build(:usuario, :cpf_com_caracter)).not_to be_valid
    end

    it "é inválido com cpf com tamanho inválido" do
      expect(build(:usuario, :cpf_tamanho_invalido)).not_to be_valid
    end

    it "é inválido com cpf com números inválidos" do
      expect(build(:usuario, :cpf_numeros_invalidos)).not_to be_valid
    end

    it "é inválido com cpf com números iguais" do
      expect(build(:usuario, :cpf_numeros_iguais)).not_to be_valid
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
    it "é inválido com telefone vazio" do
      expect(build(:usuario, :telefone_vazio)).not_to be_valid
    end

    it "é inválido com telefone com caracter não válido" do
      expect(build(:usuario, :telefone_com_caracter)).not_to be_valid
    end

    it "é inválido com telefone com tamanho inválido" do
      expect(build(:usuario, :telefone_tamanho_invalido)).not_to be_valid
    end

    it "é inválido com senha vazia" do
      expect(build(:usuario, :password_vazio)).not_to be_valid
    end

 
  end
end
