# == Survey
#
# A classe Survey representa um questionário na aplicação.
# Ela herda de ApplicationRecord e define associações com perguntas, permitindo a criação e destruição em cascata das mesmas.
#
# === Associações
# - Possui muitas perguntas (Question).
#
# === Aceitação de Atributos Aninhados
# - Aceita atributos aninhados para perguntas, permitindo que perguntas sejam criadas junto com o questionário.
#
# === Exemplos de uso
# Esta classe pode ser usada para representar e gerenciar questionários completos, com várias perguntas associadas.
#
# === Código de exemplo
#   class Survey < ApplicationRecord
#     has_many :questions, dependent: :destroy
#     accepts_nested_attributes_for :questions
#   end

class Survey < ApplicationRecord
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions
end
