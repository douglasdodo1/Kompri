FactoryBot.define do
  factory :item do
    association :compra
    association :produto
    quantidade { 1 }
    valor { 10.00 }
    comprado { false }

   trait :quantidade_vazia do
      quantidade { nil }
    end

    trait :quantidade_negativa do
      quantidade { -1 }
    end

    trait :valor_vazio do
      valor { nil }
    end

    trait :valor_negativo do
      valor { -1 }
    end
  end
end