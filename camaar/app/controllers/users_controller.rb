# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def importar_dados
    @membros = params[:file_membros]
    if @membros
      begin
        users_before_import = User.count

        # Verifique se @membros é um único arquivo ou uma lista de arquivos
        if @membros.is_a?(Array)
          @membros.each do |file|
            json_data = JSON.parse(file.read)
            process_json_data(json_data)
          end
        else
          # Se for apenas um único arquivo
          json_data = JSON.parse(@membros.read)
          process_json_data(json_data)
        end

        users_after_import = User.count
        new_users_count = users_after_import - users_before_import

        if new_users_count > 0
          flash[:success] = "Membros foram importados com sucesso. Total de novos usuários: #{new_users_count}."
        else
          flash[:error] = "Nenhum novo usuário foi importado."
        end
      rescue => e
        flash[:error] = "Houve um erro ao importar os membros: #{e.message}"
      end
    else
      flash[:error] = "Nenhum arquivo foi selecionado."
    end

    respond_to do |format|
      format.html { redirect_to users_path }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("popup-upload", partial: "shared/flash_messages") }
    end
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
end
