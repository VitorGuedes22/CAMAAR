# == UsersController
#
# Este controlador é responsável por importar dados de membros e processar usuários.
#
# === Ações Públicas
# - importar_dados
#
# === Métodos Privados
# - process_json_data
# - process_user
# - verifica_json
# - conta_usuarios
# - resposta_requisicao

class UsersController < ApplicationController
  # POST /importar_dados
  #
  # Importa dados de membros a partir de arquivos JSON e atualiza a base de dados com novos usuários.
  #
  # ==== Parâmetros
  # - +params[:file_membros]+ - O arquivo JSON contendo os dados dos membros a serem importados.
  #
  # ==== Exemplo de resposta
  # - Calcula e exibe a quantidade de novos usuários importados.
  # - Exibe uma mensagem de erro se nenhum arquivo for selecionado ou se houver um problema na importação.
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
        conta_usuarios(users_after_import, users_before_import)
      rescue => e
        flash[:error] = "Houve um erro ao importar os membros: #{e.message}"
      end
    else
      flash[:error] = "Nenhum arquivo foi selecionado."
    end

    resposta_requisicao
  end

  private

  # Processa os dados JSON e cria ou atualiza usuários.
  #
  # ==== Parâmetros
  # - +data+ - Dados JSON contendo informações de docentes e dicentes.
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

  # Cria ou atualiza um usuário com base nos dados fornecidos.
  #
  # ==== Parâmetros
  # - +user_data+ - Dados do usuário a serem processados.
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

  # Verifica se o JSON é uma lista de arquivos ou um único arquivo e processa os dados.
  #
  # ==== Parâmetros
  # - +membros+ - Arquivo ou lista de arquivos JSON contendo dados dos membros.
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

  # Calcula e exibe a quantidade de novos usuários importados.
  #
  # ==== Parâmetros
  # - +new_users_count+ - A quantidade de novos usuários importados.
  def conta_usuarios(users_after_import, users_before_import)
    new_users_count = users_after_import - users_before_import

    if new_users_count > 0
      flash[:success] = "Membros foram importados com sucesso. Total de novos usuários: #{new_users_count}."
    else
      flash[:error] = "Nenhum novo usuário foi importado."
    end
  end

  # Responde à requisição de importação de dados.
  #
  # Redireciona para a página de usuários e renderiza mensagens de flash.
  def resposta_requisicao
    respond_to do |format|
      format.html { redirect_to users_path }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("popup-upload", partial: "shared/flash_messages") }
    end
  end
end
