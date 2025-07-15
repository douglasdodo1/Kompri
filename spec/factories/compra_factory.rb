FactoryBot.define do
  factory :compra do
    association(:usuario)
    association(:instituicao)
    status { "pendente" }
    valor_total { 100.00 }
    valor_estimado { 80.00 }
    qtd_itens { 2 }

    trait :usuario_cpf_vazio do
      usuario_cpf { '' }
    end

    trait :status_vazio do
      status { '' }
    end

    trait :status_invalido do
      status { 'invalido' }
    end

    trait :valor_total_vazio do
      valor_total { nil }
    end

    trait :valor_total_negativo do
      valor_total { -10.00 }
    end

    trait :valor_estimado_vazio do
      valor_estimado { nil }
    end

    trait :valor_estimado_negativo do
      valor_estimado { -10.00 }
    end

    trait :qtd_itens_vazio do
      qtd_itens { nil }
    end

    trait :qtd_itens_negativo do
      qtd_itens { -1 }
    end
  end
end
