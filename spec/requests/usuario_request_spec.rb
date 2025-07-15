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
      it "não cria um novo usuário com CPF que contém caracter não-numérico" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :cpf_com_caracter) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["CPF Deve conter somente números"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria um novo usuário com CPF que tem tamanho inválido" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :cpf_tamanho_invalido) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["CPF Deve conter 11 números"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria um novo usuário com CPF que tem números iguais" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :cpf_numeros_iguais) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["CPF Não pode ter todos os números iguais"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria um usuário com nome vazio" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :nome_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Nome completo não pode ficar em branco", "Nome completo é muito curto (mínimo: 3 caracteres)"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria um usuário com nome menor que 3 caracteres" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :nome_curto) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Nome completo é muito curto (mínimo: 3 caracteres)"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria um usuário com nome maior que 50 caracteres" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :nome_grande) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Nome completo é muito longo (máximo: 50 caracteres)"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria usuário com email vazio" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :email_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Email não pode ficar em branco"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria usuário com telefone vazio" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :telefone_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Telefone não pode ficar em branco", "Telefone está incompleto", "Telefone deve conter exatamente 11 dígitos numéricos"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria usuário com telefone com caracter não-numérico" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :telefone_com_caracter) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Telefone deve conter exatamente 11 dígitos numéricos"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria usuário com telefone com tamanho inválido" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :telefone_tamanho_invalido) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Telefone está incompleto", "Telefone deve conter exatamente 11 dígitos numéricos"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end

      it "não cria usuário com senha vazia" do
        post "/usuarios", params: { usuario: attributes_for(:usuario, :password_vazio) }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Senha não pode ficar em branco", "Senha é muito curta (mínimo: 6 caracteres)"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
        )
      end
    end
  end

  describe "GET /usuarios/cpf" do
    context "busca usuário" do
      let(:usuario) { create(:usuario) }
      before do
        allow_any_instance_of(ApplicationController)
          .to receive(:authenticate_request!)
          .and_return(true)
      end

      it "busca um usuário com sucesso" do
        get "/usuarios/#{usuario.cpf}"
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to include(
          "nome" => usuario.nome,
          "email" => usuario.email,
          "telefone" => usuario.telefone
        )
      end

      it "não busca um usuário inexistente" do
        get "/usuarios/cpf/00000000000"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET /usuarios", type: :request do
    let!(:usuarios) { create_list(:usuario, 3) }

    before do
      allow_any_instance_of(ApplicationController)
        .to receive(:authenticate_request!)
        .and_return(true)
    end

    context "busca usuários" do
      it "retorna todos os usuários com sucesso" do
        get "/usuarios"
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).to be_an(Array)
        expect(json.size).to eq(3)

        atributos_retorno = json.map { |u| u.slice("nome", "email", "telefone") }
        usuarios.each do |usuario|
          expect(atributos_retorno).to include(
            "nome"     => usuario.nome,
            "email"    => usuario.email,
            "telefone" => usuario.telefone
          )
        end
      end
    end
  end


  describe "PATCH /usuarios/:cpf" do
    let(:usuario) { create(:usuario) }
    before do
      allow_any_instance_of(ApplicationController)
        .to receive(:authenticate_request!)
        .and_return(true)
    end
    context "atualiza usuário com sucesso" do 
      it "atualiza nome de usuário com sucesso" do
        novos_dados = attributes_for(:usuario, :nome_novo_valido).slice(:nome)
        patch "/usuarios/#{usuario.cpf}", params: { usuario: novos_dados }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to include("nome" => "Nome Novo")
      end

      it "atualiza email de usuário com sucesso" do
        novos_dados = attributes_for(:usuario, :email_novo_valido).slice(:email)
        patch "/usuarios/#{usuario.cpf}", params: { usuario: novos_dados }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to include("email" => "emailnovo@com")
      end

      it "atualiza telefone de usuário com sucesso" do
        novos_dados = attributes_for(:usuario, :telefone_novo_valido).slice(:telefone)
        patch "/usuarios/#{usuario.cpf}", params: { usuario: novos_dados }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to include("telefone" => "00000000000")
      end

      it "atualiza senha de usuário com sucesso" do
        novos_dados = attributes_for(:usuario, :password_novo_valido).slice(:password)
        patch "/usuarios/#{usuario.cpf}", params: { usuario: novos_dados }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to include(
          "password" => "Alterado com sucesso"
        )
      end
    end

    context "atualizações inválidas de usuário" do
      it "não atualiza nome vazio" do
        dados = attributes_for(:usuario, :nome_vazio).slice(:nome)
        patch "/usuarios/#{usuario.cpf}", params: { usuario: dados }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Nome completo não pode ficar em branco", "Nome completo é muito curto (mínimo: 3 caracteres)"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
          )
      end

      it "não atualiza nome com menos de 3 caracteres" do
        dados = attributes_for(:usuario, :nome_curto).slice(:nome)
        patch "/usuarios/#{usuario.cpf}", params: { usuario: dados }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Nome completo é muito curto (mínimo: 3 caracteres)"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
          )
      end

      it "não atualiza nome com mais de 100 caracteres" do
        dados = attributes_for(:usuario, :nome_grande).slice(:nome)
        patch "/usuarios/#{usuario.cpf}", params: { usuario: dados }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Nome completo é muito longo (máximo: 50 caracteres)"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
          )
      end

      it "não atualiza email vazio" do
        dados = attributes_for(:usuario, :email_vazio).slice(:email)
        patch "/usuarios/#{usuario.cpf}", params: { usuario: dados }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Email não pode ficar em branco"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid",
          )
      end

      it "não atualiza telefone vazio" do
        dados = attributes_for(:usuario, :telefone_vazio).slice(:telefone)
        patch "/usuarios/#{usuario.cpf}", params: { usuario: dados }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Telefone não pode ficar em branco", "Telefone está incompleto", "Telefone deve conter exatamente 11 dígitos numéricos"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
          )
      end

      it "não atualiza telefone com caractere não numérico" do
        dados = attributes_for(:usuario, :telefone_com_caracter).slice(:telefone)
        patch "/usuarios/#{usuario.cpf}", params: { usuario: dados }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Telefone deve conter exatamente 11 dígitos numéricos"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
          )
      end

      it "não atualiza telefone com tamanho inválido" do
        dados = attributes_for(:usuario, :telefone_tamanho_invalido).slice(:telefone)
        patch "/usuarios/#{usuario.cpf}", params: { usuario: dados }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
          "mensagens" => ["Telefone está incompleto", "Telefone deve conter exatamente 11 dígitos numéricos"],
          "modelo" => "Usuário",
          "tipo" => "ActiveRecord::RecordInvalid"
          )
      end

      it "não atualiza senha com tamanho inválido" do
        dados = attributes_for(:usuario, :password_pequeno).slice(:password)
        patch "/usuarios/#{usuario.cpf}", params: { usuario: dados }
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to include(
          "erro" => "Usuário inválido",
            "mensagens" => ["Senha é muito curta (mínimo: 6 caracteres)"],
            "modelo" => "Usuário",
            "tipo" => "ActiveRecord::RecordInvalid"
          )
      end
    end
  end

  describe "DELETE /usuarios/:cpf" do
    let(:usuario) { create(:usuario) }
    before do
      allow_any_instance_of(ApplicationController)
        .to receive(:authenticate_request!)
        .and_return(true)
    end

    context "deleta usuário com cpf existente" do
      it "deleta um usuário com sucesso" do
        delete "/usuarios/#{usuario.cpf}"
        expect(response).to have_http_status(:no_content)
      end
    end

    context "deleta usuário com cpf inexistente" do
      it "deleta um usuário inexistente" do
        delete "/usuarios/00000000000"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
