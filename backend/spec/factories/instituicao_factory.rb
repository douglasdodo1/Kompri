FactoryBot.define do
  factory :instituicao do
    nome { Faker::Name.name }

    trait :nome_vazio do
      nome { '' }
    end

    trait :nome_grande do
      nome { 'A' * 51 }
    end

    trait :nome_novo_valido do
      nome { 'Nome Novo' }
    end
  end
end