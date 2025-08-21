class Usuario < ApplicationRecord
  has_secure_password
  validates :nome, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, uniqueness: true
  
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, allow_nil: true, length: { minimum: 6 }, on: :update
  has_many :compras

  def as_json(options = {})
    super(options.merge(except: [:password_digest, :created_at, :updated_at]))
  end

end
