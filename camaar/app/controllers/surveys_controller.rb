# == SurveysController
#
# Este controlador é responsável por gerenciar as ações relacionadas à model Survey.
#
# === Filtros
# - protect_from_forgery with: :null_session
#
# === Ações Públicas
# - create
#
# === Métodos Privados
# - survey_params

class SurveysController < ApplicationController
  protect_from_forgery with: :null_session

  # POST /surveys
  #
  # Cria uma nova instância da model Survey com os parâmetros fornecidos.
  #
  # ==== Parâmetros
  # - +params[:survey]+ - Parâmetros permitidos para a criação da model Survey, incluindo perguntas e opções.
  #
  # ==== Exemplo de resposta
  # - JSON: Retorna a nova instância criada com status :created.
  # - JSON: Retorna erros de validação com status :unprocessable_entity.
  #
  def create
    survey = Survey.new(survey_params)

    if survey.save
      render json: { message: 'Survey created successfully', survey: survey }, status: :created
    else
      render json: { errors: survey.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Permite uma lista de parâmetros confiáveis para a criação da model Survey.
  #
  # ==== Parâmetros permitidos
  #
  # - +:title+
  # - +questions_attributes+: [
  #     - +:title+
  #     - +:question_type+
  #     - +options_attributes+: [
  #         - +:text+
  #       ]
  #   ]
  #
  def survey_params
    params.require(:survey).permit(:title, questions_attributes: [:title, :question_type, options_attributes: [:text]])
  end
end
