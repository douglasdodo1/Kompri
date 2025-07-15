require 'cpf_faker'

FactoryBot.define do
  factory :usuario do
    cpf { Faker::CPF.numeric }
    nome { Faker::Name.name }
    email { Faker::Internet.email }
    telefone { Faker::PhoneNumber.cell_phone.gsub(/\D/, '') }
    password { Faker::Internet.password }

    #CPF'S inválidos
    trait :cpf_vazio do
      cpf { '' }
    end

    trait :cpf_com_caracter do
      cpf { 'AAA00000000' }
    end

    trait :cpf_tamanho_invalido do
      cpf { '00000000' }
    end

    trait :cpf_numeros_iguais do
      cpf { '00000000000' }
    end

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