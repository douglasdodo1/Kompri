RSpec.describe "requisições de usuário", type: :request do
  before do
    allow_any_instance_of(ApplicationController)
      .to receive(:authenticate_request!)
      .and_return(true)
  end

  describe "POST /usuarios" do
    context "dados válidos" do
      it "cria um novo usuário com dados válidos" do
        user_attributes = attributes_for(:usuario)
        post "/usuarios", params: { usuario: user_attributes }
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json).to include(
          "nome" => user_attributes[:nome],
        )
      end
    end

    context "dados inválidos" do
      it "não cria um usuário com nome vazio" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :nome_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "não cria um usuário com nome menor que 3 caracteres" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :nome_curto) }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "não cria um usuário com nome maior que 100 caracteres" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :nome_grande) }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "não cria usuário com email vazio" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :email_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "não cria usuário com senha vazia" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :password_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /usuarios/:email" do
    let(:usuario) { create(:usuario, email: "teste@email.com") }

    it "busca um usuário com sucesso" do
      get "/usuarios/#{usuario.email}"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to include(
        "nome" => usuario.nome,
        "email" => usuario.email
      )
    end

    it "não busca um usuário inexistente" do
      get "/usuarios/inexistente@email.com"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /usuarios" do
    let!(:usuarios) { create_list(:usuario, 3) }

    it "retorna todos os usuários com sucesso" do
      get "/usuarios"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to eq(3)
      atributos_retorno = json.map { |u| u.slice("nome", "email") }
      usuarios.each do |usuario|
        expect(atributos_retorno).to include(
          "nome" => usuario.nome,
          "email" => usuario.email
        )
      end
    end
  end

  describe "PATCH /usuarios/:email" do
    let(:usuario) { create(:usuario) }

    context "atualizações válidas" do
      it "atualiza nome" do
        patch "/usuarios/#{usuario.email}", params: { usuario: { nome: "Nome Novo" } }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to include("nome" => "Nome Novo")
      end

      it "atualiza email" do
        patch "/usuarios/#{usuario.email}", params: { usuario: { email: "emailnovo@com" } }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to include("email" => "emailnovo@com")
      end

      it "atualiza senha" do
        patch "/usuarios/#{usuario.email}", params: { usuario: { password: "passwordnovo" } }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to include("password" => "Alterado com sucesso")
      end
    end

    context "atualizações inválidas" do
      it "não atualiza nome vazio" do
        patch "/usuarios/#{usuario.email}", params: { usuario: { nome: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "não atualiza nome muito curto" do
        patch "/usuarios/#{usuario.email}", params: { usuario: { nome: "AA" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "não atualiza email vazio" do
        patch "/usuarios/#{usuario.email}", params: { usuario: { email: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "não atualiza senha muito curta" do
        patch "/usuarios/#{usuario.email}", params: { usuario: { password: "123" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /usuarios/:email" do
    let(:usuario) { create(:usuario, email: "teste@email.com") }
    context "usuário existente" do
      it "deleta um usuário com sucesso" do
        delete "/usuarios/#{usuario.email}"
        expect(response).to have_http_status(:no_content)
      end
    end

    context "usuário inexistente" do
      it "retorna not_found" do
        delete "/usuarios/9999"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
