
FactoryBot.define do
  factory :usuario do
    id { Faker::Number.number(digits: 10) }
    nome { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }


    #nomes inválidos
    trait :nome_vazio do
      nome { '' }
    end

    trait :nome_curto do
      nome { 'AA' }
    end

    trait :nome_grande do
      nome {'A' * 101}
    end

    #emails inválidos
    trait :email_vazio do
      email { '' }
    end

    trait :email_sem_arroba do
      email { 'emailsemarroba.com.br' }
    end

    trait :email_sem_ponto do
      email { 'emailsemarroba@combr' }
    end

    trait :telefone_vazio do
      telefone { '' }
    end

    trait :telefone_com_caracter do
      telefone { 'AAA00000000' }
    end

    trait :telefone_tamanho_invalido do
      telefone { '00000000' }
    end

    #password's
    trait :password_vazio do
      password { '' }
    end

    trait :password_pequeno do
      password { 'AAA' }
    end


    #atualização de dados válidos
    trait :nome_novo_valido do
      nome { 'Nome Novo' }
    end

    trait :email_novo_valido do
      email { 'emailnovo@com' }
    end

    trait :telefone_novo_valido do
      telefone { '00000000000' }
    end

    trait :password_novo_valido do
      password { 'passwordnovo' }
    end
  end
 
end