# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def importar_dados
    @membros = params[:file_membros]
    if @membros
      begin
        # Calcula a quantidade de usuários antes de importar
        users_before_import = User.count

        # Função que verifica se o json é um único arquivo ou uma lista
        verifica_json(@membros)

        # Calcula a quantidade de usuários depois de importar
        users_after_import = User.count
        # Calcula a diferença de usuários antes e depois da importação
        new_users_count = users_after_import - users_before_import

        conta_usuarios(new_users_count)
      rescue => e
        flash[:error] = "Houve um erro ao importar os membros: #{e.message}"
      end
    else
      flash[:error] = "Nenhum arquivo foi selecionado."
    end

    resposta_requisicao
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
    user = User.find_or_initialize_by(usuario: user_data['usuario'])
    user.assign_attributes(
      nome: user_data['nome'],
      curso: user_data['curso'],
      matricula: user_data['matricula'],
      formacao: user_data['formacao'],
      ocupacao: user_data['ocupacao'],
      email: user_data['email'],
      senha: "a",
      password: "a"
    )
    user.save!
  end

  private

  def verifica_json(membros)
    # Verifica se o json é uma lista de arquivos
    if membros.is_a?(Array)
      membros.each do |file|
        json_data = JSON.parse(file.read)
        process_json_data(json_data)
      end
    else
      # Se for apenas um único arquivo
      json_data = JSON.parse(membros.read)
      process_json_data(json_data)
    end
  end

  def conta_usuarios(new_users_count)
    if new_users_count > 0
      flash[:success] = "Membros foram importados com sucesso. Total de novos usuários: #{new_users_count}."
    else
      flash[:error] = "Nenhum novo usuário foi importado."
    end
  end

  def resposta_requisicao
    respond_to do |format|
      format.html { redirect_to users_path }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("popup-upload", partial: "shared/flash_messages") }
    end
  end
end
