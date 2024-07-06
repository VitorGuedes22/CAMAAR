# == Membership
#
# A classe Membership representa a associação de um usuário a uma classe de curso na aplicação.
# Ela herda de ApplicationRecord e define associações com usuários e classes de curso, além de validar o papel do usuário na associação.
#
# === Associações
# - Pertence a um usuário (User).
# - Pertence a uma classe de curso (CourseClass).
#
# === Validações
# - Valida a presença do atributo papel (:role).
# - Valida a inclusão do papel em uma lista específica ('docente' ou 'discente').
#
# === Exemplos de uso
# Esta classe pode ser usada para gerenciar e validar as associações de usuários em classes de curso, garantindo que o papel do usuário seja correto.
#
# === Código de exemplo
#   class Membership < ApplicationRecord
#     belongs_to :user
#     belongs_to :course_class
#
#     validates :role, presence: true, inclusion: { in: %w[docente discente] }
#   end

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :course_class

  validates :role, presence: true, inclusion: { in: %w[docente discente] }
end
