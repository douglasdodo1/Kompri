RSpec.describe "requisições de instituiçãos", type: :request do
  let(:usuario) { create(:usuario) }
  before do
    allow_any_instance_of(ApplicationController)
      .to receive(:authenticate_request!)
      .and_return(true)
  end

  describe "POST /instituicoes" do
    context "dados válidos" do
      it "cria uma nova instituição com dados válidos" do
        instituicao_attributes = attributes_for(:instituicao)
        post "/instituicoes", params: { instituicao: instituicao_attributes }
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json).to include(
          "nome" => instituicao_attributes[:nome]
        )
      end

      context "dados inválidos" do
        it "não cria uma nova instituição com nome vazio" do
          post "/instituicoes", params: { instituicao: attributes_for(:instituicao, :nome_vazio) }
          expect(response).to have_http_status(:unprocessable_entity)
          json = JSON.parse(response.body)
          expect(json).to include(
            "erro" => "Instituição inválido",
            "mensagens" => ["Nome não pode ficar em branco"],
            "tipo" => "ActiveRecord::RecordInvalid"
          )
        end

        it "não cria uma nova instituição com nome muito grande" do
          post "/instituicoes", params: { instituicao: attributes_for(:instituicao, :nome_grande) }
          expect(response).to have_http_status(:unprocessable_entity)
          json = JSON.parse(response.body)
          expect(json).to include(
            "erro" => "Instituição inválido",
            "mensagens" => ["Nome é muito longo (máximo: 50 caracteres)"],
            "modelo" => "Instituição",
          )
        end
      end
    end
  end

  describe "GET /instituicoes/:id" do
    let(:instituicao) { create(:instituicao) }
    it "busca uma instituição com sucesso" do
      get "/instituicoes/#{instituicao.id}"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to include(
        "nome" => instituicao.nome
      )
    end

    it "não busca uma instituição inexistente" do
      get "/instituicoes/0"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /instituicoes" do
    let!(:instituicoes) { create_list(:instituicao, 3) }
    it "retorna todas as instituição com sucesso" do
      get "/instituicoes"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json).to be_an(Array)
      expect(json.size).to eq(3)
      instituicoes.each do |instituicao|
        expect(json).to include(
          a_hash_including("nome" => instituicao.nome)
        )
      end
    end
  end

  describe "PATCH /instituicoes/:id" do
    let(:instituicao) { create(:instituicao) }
    context "dados válidos" do
      it "atualiza uma instituição com sucesso" do
        novos_dados = attributes_for(:instituicao, :nome_novo_valido).slice(:nome)
        patch "/instituicoes/#{instituicao.id}", params: { instituicao: novos_dados }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to include("nome" => "Nome Novo")
      end
    end

    context "dados inválidos" do
      it "não atualiza uma instituição com nome vazio" do
        patch "/instituicoes/#{instituicao.id}", params: { instituicao: attributes_for(:instituicao, :nome_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Instituição inválido",
          "mensagens" => ["Nome não pode ficar em branco"],
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end
    end
  end

  describe "DELETE /instituicoes/:id" do
    context "deleta instituição com id existente" do
      let(:instituicao) { create(:instituicao) }
      it "deleta uma instituição com sucesso" do
        delete "/instituicoes/#{instituicao.id}"
        expect(response).to have_http_status(:no_content)
      end
    end

    context "deleta instituição com id inexistente" do
      it "não deleta uma instituição inexistente" do
        delete "/instituicoes/0"
        expect(response).to have_http_status(:not_found)
      end
    end
  end



end