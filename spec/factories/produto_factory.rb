FactoryBot.define do
  factory :produto do
    nome { Faker::Commerce.product_name }
    marca { Faker::Commerce.brand }
    categoria { Faker::Commerce.department }
  end

  trait :nome_vazio do
    nome { '' }
  end

  trait :nome_curto do
    nome { 'AA' }
  end

  trait :nome_grande do
    nome { 'A' * 101 }
  end


  trait :marca_grande do
    marca { 'A' * 101 }
  end

end