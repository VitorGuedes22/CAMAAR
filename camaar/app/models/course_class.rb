# == CourseClass
#
# A classe CourseClass representa uma classe de curso na aplicação.
# Ela herda de ApplicationRecord e define associações com outras entidades.
#
# === Associações
# - Possui muitas associações com membros (Membership).
# - Possui muitos usuários através de membros (Membership).
#
# === Exemplos de uso
# Esta classe pode ser usada para gerenciar e associar usuários a uma classe de curso específica.
#
# === Código de exemplo
#   class CourseClass < ApplicationRecord
#     has_many :memberships
#     has_many :users, through: :memberships
#   end

class CourseClass < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
end
