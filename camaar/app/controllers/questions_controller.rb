# == QuestionsController
#
# Este controlador é responsável por gerenciar as ações relacionadas à model Question.
#
# === Filtros
# - protect_from_forgery with: :null_session
#
# === Ações Públicas
# - home
# - create
#
# === Métodos Privados
# - question_params

class QuestionsController < ApplicationController
  protect_from_forgery with: :null_session

  # GET /questions/home
  #
  # Retorna todas as instâncias da model Question.
  #
  # ==== Exemplo de resposta
  #
  #   [
  #     { id: 1, title: 'Question 1', question_type: 'Type 1', ... },
  #     { id: 2, title: 'Question 2', question_type: 'Type 2', ... }
  #   ]
  #
  def home
    @questions = Question.all
  end

  # POST /questions
  #
  # Cria uma nova instância da model Question com os parâmetros fornecidos.
  #
  # ==== Parâmetros
  #
  # - +question_params+ - Parâmetros permitidos para a criação da model Question.
  #
  # ==== Exemplo de resposta
  #
  # - JSON: Retorna a nova instância criada com status :created.
  # - JSON: Retorna erros de validação com status :unprocessable_entity.
  #
  def create
    question = Question.new(question_params)
    if question.save
      render json: { status: 'success', question: question }, status: :created
    else
      render json: { status: 'error', errors: question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Permite uma lista de parâmetros confiáveis para a criação da model Question.
  #
  # ==== Parâmetros permitidos
  #
  # - +:title+
  # - +:question_type+
  # - +options_attributes+: [
  #     - +:text+
  #   ]
  #
  def question_params
    params.require(:question).permit(:title, :question_type, options_attributes: [:text])
  end
end
