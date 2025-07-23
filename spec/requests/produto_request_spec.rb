RSpec.describe "requisições de produtos", type: :request do
  before do
    allow_any_instance_of(ApplicationController)
      .to receive(:authenticate_request!)
      .and_return(true)
  end
  describe "POST /produtos" do
    context "dados válidos" do
      it "cria um novo produto com dados válidos" do
        produto_attributes = attributes_for(:produto)
        post "/produtos", params: { produto: produto_attributes }
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json).to include(
          "nome" => produto_attributes[:nome],
          "marca" => produto_attributes[:marca],
          "categoria" => produto_attributes[:categoria]
        )
      end
    end

    context "dados inválidos" do
      it "não cria um novo produto com nome vazio" do
        post "/produtos", params: { produto: attributes_for(:produto, :nome_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Produto inválido",
          "mensagens" => ["Nome não pode ficar em branco", "Nome é muito curto (mínimo: 3 caracteres)"],
          "modelo" => "Produto"
        )
      end

      it "não cria um novo produto com nome muito curto" do
        post "/produtos", params: { produto: attributes_for(:produto, :nome_curto) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Produto inválido",
          "mensagens" => ["Nome é muito curto (mínimo: 3 caracteres)"],
          "modelo" => "Produto"
        )
      end

      it "não cria um novo produto com nome muito longo" do
        post "/produtos", params: { produto: attributes_for(:produto, :nome_grande) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Produto inválido",
          "mensagens" => ["Nome é muito longo (máximo: 100 caracteres)"],
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria um novo produto com marca muito longa" do
        post "/produtos", params: { produto: attributes_for(:produto, :marca_grande) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Produto inválido",
          "mensagens" => ["Marca é muito longa (máximo: 100 caracteres)"],
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end
    end
  end


end