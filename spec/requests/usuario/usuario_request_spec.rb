RSpec.describe "requisições de usuário", type: :request do
  describe "POST /usuarios" do
    context "dados válidos" do
      it "cria um novo usuário com dados válidos" do
        user_attributes = attributes_for(:usuario)
        post "/usuarios", params: { usuario: user_attributes }
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json).to include(
          "nome" => user_attributes[:nome],
          "email" => user_attributes[:email],
          "telefone" => user_attributes[:telefone]
        )
      end
    end

    context "dados inválidos" do
      it "não cria um novo usuário com CPF inválido" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :cpf_com_caracter) }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
