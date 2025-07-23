require "rails_helper"

RSpec.describe Instituicao, type: :model do
  describe "validações de instituição" do
    it "é válido com atributos válidos" do
      expect(build(:instituicao)).to be_valid
    end

    it "é inválido com nome vazio" do
      expect(build(:instituicao, :nome_vazio)).not_to be_valid
    end

    it "é inválido com nome grande" do
      expect(build(:instituicao, :nome_grande)).not_to be_valid
    end
  end
end