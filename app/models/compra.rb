class Compra < ApplicationRecord
  belongs_to :usuario, foreign_key: :usuario_cpf, primary_key: :cpf, class_name: "Usuario"
  belongs_to :instituicao

  validates :usuario_cpf, presence: true
  validates :status, presence: true, inclusion: { in: %w[pendente concluida cancelada] }
  validates :valor_total, presence: true, numericality: { greater_than: 0 }
  validates :valor_estimado, presence: true, numericality: { greater_than: 0 }
  validates :qtd_itens, presence: true, numericality: { greater_than: 0 }
end
