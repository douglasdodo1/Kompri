require "rails_helper"

RSpec.describe Compra, type: :request do
  before do
    allow_any_instance_of(ApplicationController)
      .to receive(:authenticate_request!)
      .and_return(true)
  end

  let!(:usuario) { create(:usuario, cpf: "12345678909") }
  let!(:instituicao) { create(:instituicao) }

   describe "POST /compras" do
    it "cria uma nova compra com dados válidos" do
      post "/compras",
      params: { compra: attributes_for(:compra, usuario_cpf: usuario.cpf, instituicao_id: instituicao.id) }.to_json,
      headers: { "CONTENT_TYPE" => "application/json" }

      expect(response).to have_http_status(:created)
    end

    context "dados inválidos" do
      it "não cria uma compra com CPF vazio" do

        post "/compras", params: { compra: attributes_for(:compra, :usuario_cpf_vazio, instituicao_id: instituicao.id) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Usuario deve estar associada", "Usuário cpf não pode ficar em branco"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end
      it "não cria uma compra com status vazio" do
        post "/compras", params: { compra: attributes_for(:compra, :status_vazio, usuario_cpf: usuario.cpf, instituicao_id: instituicao.id) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Status não pode ficar em branco", "Status deve ser 'pendente', 'concluida' ou 'cancelada'"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com instituicao_id inválido" do
        post "/compras", params: { compra: attributes_for(:compra, usuario_cpf: usuario.cpf, instituicao_id: nil) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Instituição deve estar associada"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com status inválido" do
        post "/compras", params: { compra: attributes_for(:compra, :status_invalido, usuario_cpf: usuario.cpf, instituicao_id: instituicao.id) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Status deve ser 'pendente', 'concluida' ou 'cancelada'"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com valor_total vazio" do
        post "/compras", params: { compra: attributes_for(:compra, :valor_total_vazio, usuario_cpf: usuario.cpf, instituicao_id: instituicao.id) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Valor total não pode ficar em branco", "Valor total deve ser um número"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com valor_total negativo" do
        post "/compras", params: { compra: attributes_for(:compra, :valor_total_negativo, usuario_cpf: usuario.cpf), instituicao_id: instituicao.id }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Instituição deve estar associada", "Valor total deve ser maior que 0"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com valor_estimado vazio" do
        post "/compras", params: { compra: attributes_for(:compra, :valor_estimado_vazio, usuario_cpf: usuario.cpf, instituicao_id: instituicao.id) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Valor estimado não pode ficar em branco", "Valor estimado deve ser um número"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria uma compra com valor_estimado negativo" do
        post "/compras", params: { compra: attributes_for(:compra, :valor_estimado_negativo, usuario_cpf: usuario.cpf, instituicao_id: instituicao.id) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Valor estimado deve ser maior que 0"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end
    end
  end

  describe "GET /compras/:id" do
    let(:compra) { create(:compra, usuario: usuario, instituicao: instituicao) }

    it "busca uma compra com sucesso" do
      get "/compras/#{compra.id}"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to include(
        "usuario_cpf" => compra.usuario.cpf,
        "instituicao_id" => compra.instituicao.id,
        "status" => compra.status,
        "valor_total" => compra.valor_total.to_s,
        "valor_estimado" => compra.valor_estimado.to_s,
        "qtd_itens" => compra.qtd_itens
      )
    end

    it "não busca uma compra inexistente" do
      get "/compras/0"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /compras" do
    let!(:compras) { create_list(:compra, 3, usuario: usuario, instituicao: instituicao) }

    it "retorna todas as compras com sucesso" do
      get "/compras"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to eq(3)
      expect(json.first).to include(
        "usuario_cpf" => compras.first.usuario.cpf,
        "instituicao_id" => compras.first.instituicao.id,
        "status" => compras.first.status,
        "valor_total" => compras.first.valor_total.to_s,
        "valor_estimado" => compras.first.valor_estimado.to_s,
        "qtd_itens" => compras.first.qtd_itens
      )
    end

    it "retorna uma lista vazia se não houver compras" do
      Compra.destroy_all
      get "/compras"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to be_empty
    end
  end

  describe "PATCH /compras/:id" do
    let(:compra) { create(:compra, usuario: usuario, instituicao: instituicao) }

    context "dados válidos" do
      it "atualiza uma compra com dados válidos" do
        patch "/compras/#{compra.id}",
        params: { compra: attributes_for(:compra, status: "concluida", valor_total: 150.00) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to include(
          "status" => "concluida",
          "valor_total" => "150.0"
        )
      end
    end

    context "dados inválidos" do
      it "não atualiza uma compra com status vazio" do
        patch "/compras/#{compra.id}", params: { compra: attributes_for(:compra, :status_vazio) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Status não pode ficar em branco", "Status deve ser 'pendente', 'concluida' ou 'cancelada'"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não atualiza uma compra com status inválido" do
        patch "/compras/#{compra.id}", params: { compra: attributes_for(:compra, :status_invalido) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Status deve ser 'pendente', 'concluida' ou 'cancelada'"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não atualiza uma compra com valor_total vazio" do
        patch "/compras/#{compra.id}", params: { compra: attributes_for(:compra, :valor_total_vazio) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Valor total não pode ficar em branco", "Valor total deve ser um número"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não atualiza uma compra com valor_total negativo" do
        patch "/compras/#{compra.id}", params: { compra: attributes_for(:compra, :valor_total_negativo) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Valor total deve ser maior que 0"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não atualiza uma compra com valor_estimado vazio" do
        patch "/compras/#{compra.id}", params: { compra: attributes_for(:compra, :valor_estimado_vazio) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Valor estimado não pode ficar em branco", "Valor estimado deve ser um número"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não atualiza uma compra com valor_estimado negativo" do
        patch "/compras/#{compra.id}", params: { compra: attributes_for(:compra, :valor_estimado_negativo) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Valor estimado deve ser maior que 0"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não atualiza uma compra com qtd_itens vazio" do
        patch "/compras/#{compra.id}", params: { compra: attributes_for(:compra, :qtd_itens_vazio) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Quantidade de itens não pode ficar em branco", "Quantidade de itens deve ser um número"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não atualiza uma compra com qtd_itens negativo" do
        patch "/compras/#{compra.id}", params: { compra: attributes_for(:compra, :qtd_itens_negativo) }.to_json,
        headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Compra inválido",
          "mensagens" => ["Quantidade de itens deve ser maior que 0"],
          "modelo" => "Compra",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end
    end
  end

  describe "DELETE /compras/:id" do
    let(:compra) { create(:compra, usuario: usuario, instituicao: instituicao) }

    context "deleta compra com id existente" do
      it "deleta uma compra com sucesso" do
        delete "/compras/#{compra.id}"
        expect(response).to have_http_status(:no_content)
      end
    end

    context "deleta compra com id inexistente" do
      it "não deleta uma compra inexistente" do
        delete "/compras/0"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end