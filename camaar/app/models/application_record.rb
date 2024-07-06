# == ApplicationRecord
#
# A classe ApplicationRecord é a superclasse base para todos os modelos do ActiveRecord na aplicação.
# Ela herda de ActiveRecord::Base e é definida como uma classe abstrata primária, o que significa que
# não deve ser instanciada diretamente, mas deve ser herdada por outros modelos da aplicação.
#
# === Exemplos de uso
# Todos os modelos do ActiveRecord na aplicação devem herdar de ApplicationRecord.
#
# === Código de exemplo
#   class User < ApplicationRecord
#     # Código do modelo User
#   end

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
