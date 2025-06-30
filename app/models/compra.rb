class Compra < ApplicationRecord
  belongs_to :user, presence: true, foreign_key: true
  belongs_to :instituicao, presence: true, foreign_key: true

  validates :status, presence: true, inclusion: { in: %w[pendente concluida cancelada] }
  validates :valor_total, presence: true, numericality: { greater_than: 0 }
  validates :valor_estimado, presence: true, numericality: { greater_than: 0 }
  validates :qtd_itens, presence: true, numericality: { greater_than: 0 }

end
