class Produto < ApplicationRecord
  validates :nome, presence: true, length: { minimum: 3, maximum: 100 }
  validates :marca, :categoria, length: { minimum: 3, maximum: 100 }, allow_blank: true
end
