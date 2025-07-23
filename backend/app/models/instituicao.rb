class Instituicao < ApplicationRecord
  validates :nome, presence: true, length: { maximum: 50 }
  has_many :compras
end
