require "rails_helper"

RSpec.describe Compra, type: :request do
  before do
    allow_any_instance_of(ApplicationController)
      .to receive(:authenticate_request!)
      .and_return(true)
  end
   describe "POST /compras" do
    let!(:usuario) { create(:usuario, cpf: "12345678909") }
    let!(:instituicao) { create(:instituicao, id: 1) }

    let(:valid_params) do
      {
        usuario_cpf: usuario.cpf,
        status: "pendente",
        instituicao_id: instituicao.id,
        valor_total: 100.0,
        valor_estimado: 80.0,
        qtd_itens: 2
      }
    end

    it "cria uma nova compra com dados válidos" do
      post "/compras", params: valid_params.to_json, headers: { "CONTENT_TYPE" => "application/json" }

      puts response.status
      puts response.body

      expect(response).to have_http_status(:created)
      expect(Compra.count).to eq(1)
    end

    context "dados inválidos" do
      it "não cria uma compra com CPF vazio" do
        post "/compras", params: { compra: attributes_for(:compra, :usuario_cpf_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválida",
          "mensagens" => ["CPF Deve conter somente números"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com status vazio" do
        post "/compras", params: { compra: attributes_for(:compra, :status_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválida",
          "mensagens" => ["Status não pode ser vazio"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com instituicao_id inválido" do
        post "/compras", params: { compra: attributes_for(:compra, instituicao_id: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválida",
          "mensagens" => ["Instituição não pode ser vazia"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com status inválido" do
        post "/compras", params: { compra: attributes_for(:compra, :status_invalido) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválida",
          "mensagens" => ["Status é inválido"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com valor_total vazio" do
        post "/compras", params: { compra: attributes_for(:compra, :valor_total_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválida",
          "mensagens" => ["Valor total é obrigatório"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com valor_total negativo" do
        post "/compras", params: { compra: attributes_for(:compra, :valor_total_negativo) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválida",
          "mensagens" => ["Valor total deve ser maior que 0"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com valor_estimado vazio" do
        post "/compras", params: { compra: attributes_for(:compra, :valor_estimado_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválida",
          "mensagens" => ["Valor estimado é obrigatório"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com valor_estimado negativo" do
        post "/compras", params: { compra: attributes_for(:compra, :valor_estimado_negativo) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválida",
          "mensagens" => ["Valor estimado deve ser maior que 0"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end
    end
  end
end