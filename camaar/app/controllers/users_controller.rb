# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def importar_dados
    params[:files].each do |file|
      json_data = JSON.parse(file.read)
      process_json_data(json_data)
    end
    redirect_to root_path, notice: 'Dados importados com sucesso!'
  end

  private

  def process_json_data(data)
    data.each do |entry|
      docente = entry['docente']
      dicente = entry['dicente']

      # Processa o docente
      process_user(docente)

      # Processa os dicentes
      dicente.each { |d| process_user(d) }
    end
  end

  def process_user(user_data)
    User.create!(
      nome: user_data['nome'],
      curso: user_data['curso'],
      matricula: user_data['matricula'],
      usuario: user_data['usuario'],
      formacao: user_data['formacao'],
      ocupacao: user_data['ocupacao'],
      email: user_data['email']
    )
  end
end
