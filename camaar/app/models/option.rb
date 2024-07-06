# == Option
#
# A classe Option representa uma opção associada a uma pergunta na aplicação.
# Ela herda de ApplicationRecord e define uma associação de pertencimento a uma pergunta.
#
# === Associações
# - Pertence a uma pergunta (Question).
#
# === Exemplos de uso
# Esta classe pode ser usada para representar opções disponíveis em perguntas de questionários ou pesquisas.
#
# === Código de exemplo
#   class Option < ApplicationRecord
#     belongs_to :question
#   end

class Option < ApplicationRecord
  belongs_to :question
end
