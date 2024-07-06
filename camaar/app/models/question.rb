# == Question
#
# A classe Question representa uma pergunta associada a um questionário na aplicação.
# Ela herda de ApplicationRecord e define associações com opções de resposta e questionários.
#
# === Associações
# - Pertence a um questionário (Survey).
# - Possui muitas opções de resposta (Option).
#
# === Aceitação de Atributos Aninhados
# - Aceita atributos aninhados para opções de resposta, permitindo que opções sejam criadas junto com a pergunta.
#
# === Exemplos de uso
# Esta classe pode ser usada para gerenciar perguntas em questionários, permitindo múltiplas opções de resposta associadas a cada pergunta.
#
# === Código de exemplo
#   class Question < ApplicationRecord
#     belongs_to :survey
#     has_many :options, dependent: :destroy
#     accepts_nested_attributes_for :options
#   end

class Question < ApplicationRecord
  belongs_to :survey
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options
end
