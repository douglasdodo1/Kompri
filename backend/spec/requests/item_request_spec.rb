RSpec.describe "requisições de itens", type: :request do
  before do
    allow_any_instance_of(ApplicationController)
      .to receive(:authenticate_request!)
      .and_return(true)
  end
  let(:usuario) { create(:usuario) }
  let(:instituicao) { create(:instituicao) }
  let(:compra) { create(:compra, instituicao_id: instituicao.id) }
  let(:produto) { create(:produto) }

  describe "POST /itens" do
    context "dados válidos" do
      it "cria um novo item com dados válidos" do
        post "/items", params: {
          itens: [{ item: attributes_for(:item, compra_id: compra.id, produto_id: produto.id) }]}.to_json,
        headers: { "Content-Type" => "application/json" }
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
      end
    end

    context "dados inválidos" do
      it "não cria um novo item com quantidade vazia" do
        post "/items", params: {
          itens: [{ item: attributes_for(:item, :quantidade_vazia, compra_id: compra.id, produto_id: produto.id) }]}.to_json,
        headers: { "Content-Type" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Item inválido",
          "mensagens" => ["Quantidade não pode ficar em branco", "Quantidade deve ser um número"],
          "modelo" => "Item",
          "tipo" => "ActiveRecord::RecordInvalid",
        )
      end

      it "não cria um novo item com quantidade negativa" do
        post "/items", params: {
        itens: [{ item: attributes_for(:item, :quantidade_negativa, compra_id: compra.id, produto_id: produto.id) }]}.to_json,
        headers: { "Content-Type" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Item inválido",
          "mensagens" => ["Quantidade deve ser maior que 0"],
          "modelo" => "Item",
          "tipo" => "ActiveRecord::RecordInvalid",
        )
      end

      it "não cria um novo item com valor vazio" do
        post "/items", params: {
          itens: [{ item: attributes_for(:item, :valor_vazio, compra_id: compra.id, produto_id: produto.id) }]}.to_json,
          headers: { "Content-Type" => "application/json" }
          expect(response).to have_http_status(:unprocessable_entity)
          json = JSON.parse(response.body)
          expect(json).to include(
            "erro" => "Item inválido",
            "mensagens" => ["Valor não pode ficar em branco", "Valor deve ser um número"],
            "modelo" => "Item",
            "tipo" => "ActiveRecord::RecordInvalid",
          )
      end

      it "não cria um novo item com valor negativo" do
        post "/items", params: {
          itens: [{ item: attributes_for(:item, :valor_negativo, compra_id: compra.id, produto_id: produto.id) }]}.to_json,
          headers: { "Content-Type" => "application/json" }
          expect(response).to have_http_status(:unprocessable_entity)
          json = JSON.parse(response.body)
          expect(json).to include(
            "erro" => "Item inválido",
            "mensagens" => ["Valor deve ser maior que 0"],
            "modelo" => "Item",
            "tipo" => "ActiveRecord::RecordInvalid",
          )
      end

      it "não cria um novo item com compra_id inválido" do
        post "/items", params: {
          itens: [{ item: attributes_for(:item, compra_id: nil, produto_id: produto.id) }]}.to_json,
          headers: { "Content-Type" => "application/json" }
          expect(response).to have_http_status(:unprocessable_entity)
          json = JSON.parse(response.body)
          expect(json).to include(
            "erro" => "Item inválido",
            "mensagens" => ["Compra deve estar associada"],
            "modelo" => "Item",
            "tipo" => "ActiveRecord::RecordInvalid",
          )
      end

      it "não cria um novo item com produto_id inválido" do
        post "/items", params: {
          itens: [{ item: attributes_for(:item, compra_id: compra.id, produto_id: nil) }]}.to_json,
          headers: { "Content-Type" => "application/json" }
          expect(response).to have_http_status(:unprocessable_entity)
          json = JSON.parse(response.body)
          expect(json).to include(
            "erro" => "Item inválido",
            "mensagens" => ["Produto deve estar associada"],
            "modelo" => "Item",
            "tipo" => "ActiveRecord::RecordInvalid",
          )
      end
    end
  end

  describe "GET /itens/:id" do
    it "retorna um item específico" do
      item = create(:item, compra: compra, produto: produto)
      get "/items/#{item.id}"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["produto"]["nome"]).to eq(produto.nome)
      expect(json["compra"]["valor_total"].to_f).to eq(compra.valor_total)
    end

    it "retorna 404 para item não encontrado" do
      get "/items/0"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /itens" do
    it "retorna todos os itens" do
      item = create(:item, compra: compra, produto: produto)
      get "/items"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
      expect(json.first["produto"]["nome"]).to eq(produto.nome)
      expect(json.first["compra"]["valor_total"].to_f).to eq(compra.valor_total)
      expect(json.first["quantidade"]).to eq(item.quantidade)
      expect(json.first["valor"].to_f).to eq(item.valor)
      expect(json.first["comprado"]).to eq(item.comprado)
    end

    it "retorna uma lista vazia se não houver itens" do
      get "/items"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to be_empty
    end
  end

  describe "PATCH /itens/:id" do
    context "dados válidos" do 
      it "atualiza um item com dados válidos" do
        item = create(:item, compra: compra, produto: produto)
        patch "/items/#{item.id}", params: {
          item: attributes_for(:item, quantidade: 2, valor: 20.00)
        }.to_json, headers: { "Content-Type" => "application/json" }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["quantidade"]).to eq(2)
        expect(json["valor"].to_f).to eq(20.00)
      end
    end

    context "dados inválidos" do
      it "não atualiza um item com quantidade vazia" do
        item = create(:item, compra: compra, produto: produto)
        patch "/items/#{item.id}", params: {
          item: attributes_for(:item, :quantidade_vazia)
        }.to_json, headers: { "Content-Type" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Item inválido",
          "mensagens" => ["Quantidade não pode ficar em branco", "Quantidade deve ser um número"],
          "modelo" => "Item",
          "tipo" => "ActiveRecord::RecordInvalid",
        )
      end

      it "não atualiza um item com quantidade negativa" do
        item = create(:item, compra: compra, produto: produto)
        patch "/items/#{item.id}", params: {
          item: attributes_for(:item, :quantidade_negativa)
        }.to_json, headers: { "Content-Type" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Item inválido",
          "mensagens" => ["Quantidade deve ser maior que 0"],
          "modelo" => "Item",
          "tipo" => "ActiveRecord::RecordInvalid",
        )
      end

      it "não atualiza um item com valor vazio" do
        item = create(:item, compra: compra, produto: produto)
        patch "/items/#{item.id}", params: {
          item: attributes_for(:item, :valor_vazio)
        }.to_json, headers: { "Content-Type" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Item inválido",
          "mensagens" => ["Valor não pode ficar em branco", "Valor deve ser um número"],
          "modelo" => "Item",
          "tipo" => "ActiveRecord::RecordInvalid",
        )
      end

      it "não atualiza um item com valor negativo" do
        item = create(:item, compra: compra, produto: produto)
        patch "/items/#{item.id}", params: {
          item: attributes_for(:item, :valor_negativo)
        }.to_json, headers: { "Content-Type" => "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Item inválido",
          "mensagens" => ["Valor deve ser maior que 0"],
          "modelo" => "Item",
          "tipo" => "ActiveRecord::RecordInvalid",
        )
      end
    end
  end

  describe "DELETE /itens/:id" do
    it "deleta um item existente" do
      item = create(:item, compra: compra, produto: produto)
      delete "/items/#{item.id}"
      expect(response).to have_http_status(:no_content)
      expect(Item.exists?(item.id)).to be_falsey
    end

    it "retorna 404 para item não encontrado" do
      delete "/items/0"
      expect(response).to have_http_status(:not_found)
    end
  end
end