class Usuario < ApplicationRecord
  self.primary_key = :cpf
  has_secure_password
  validate :valid_cpf
  validates :nome, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, uniqueness: true
  validates :telefone, presence: true, length: { minimum: 11, maximum: 11 }

  has_many :compras
  def as_json(options = {})
    super(options.merge(except: [:cpf,:password_digest, :created_at, :updated_at]))
  end

  private

  def valid_cpf
    if cpf.nil?
      errors.add(:cpf, "Não pode ser vazio")
      return
    end

    unless cpf.match?(/\A\d+\z/)
      errors.add(:cpf, "Deve conter somente números")
      return
    end

    if cpf.length != 11
      errors.add(:cpf, "Deve conter 11 números")
      return
    end

    if cpf.chars.uniq.length == 1
      errors.add(:cpf, "Não pode ter todos os números iguais")
      return
    end

    sum = 0
    first_number_check = 0
    second_number_check = 0

    number_cpf = cpf.chars.map(&:to_i)

    9.times do |i|
      sum += number_cpf[i] * (10 - i)
    end

    first_number_check = (sum*10) % 11
    first_number_check = 0 if first_number_check == 10

    unless first_number_check == number_cpf[9]
      errors.add(:cpf, "Não é válido")
      return
    end

    sum = 0

    10.times do |i|
      sum += number_cpf[i] * (11-i)
    end

    second_number_check = (sum*10) % 11
    second_number_check = 0 if second_number_check == 10

    unless second_number_check == number_cpf[10]
      errors.add(:cpf, "Não é válido")
    end
  end
end
