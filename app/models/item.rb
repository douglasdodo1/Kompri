class Item < ApplicationRecord
  belongs_to :compra
  belongs_to :produto

  validates :quantidade, presence: true, numericality: { greater_than: 0 }
  validates :valor, presence: true, numericality: { greater_than: 0 }
end
