# == User
#
# A classe User representa um usuário na aplicação.
# Ela herda de ApplicationRecord e define associações com classes de curso através de associações de adesão (Membership).
# Além disso, utiliza has_secure_password para criptografar e validar a senha do usuário.
#
# === Associações
# - Possui muitas associações com classes de curso através de membros (Membership).
#
# === Validações
# - Valida a presença e a unicidade do atributo usuário (:usuario).
# - Valida a presença da senha (:password) apenas na atualização do usuário, permitindo nulo durante a criação.
#
# === Código de exemplo
#   class User < ApplicationRecord
#     has_many :memberships
#     has_many :course_classes, through: :memberships
#
#     has_secure_password(validations: false)
#
#     validates :usuario, presence: true, uniqueness: true
#     validates :password, presence: true, on: :update, allow_nil: true
#   end

class User < ApplicationRecord
  has_many :memberships
  has_many :course_classes, through: :memberships

  has_secure_password(validations: false)

  validates :usuario, presence: true, uniqueness: true
  validates :password, presence: true, on: :update, allow_nil: true
end
