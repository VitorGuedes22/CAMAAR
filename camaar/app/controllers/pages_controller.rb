# == PagesController
#
# Este controlador é responsável por gerenciar diversas ações de páginas, como login, home, recuperação de senha, criação de template, resultados, avaliações, questionários, gerenciamento, templates e importação de dados.
#
# === Ações Públicas
# - login
# - home
# - recuperar_senha
# - update_password
# - criar_templete
# - resultados
# - avaliacoes
# - questionarios
# - gerenciamento
# - templates
# - importar_dados
#
# === Métodos Privados
# - process_files
# - process_json_data
# - process_user
# - process_class_data

class PagesController < ApplicationController
  # Renderiza a view de login
  def login
  end

  # Renderiza a view de home
  def home
  end

  # Renderiza a view de recuperação de senha e define o @username
  def recuperar_senha
    @username = params[:username]
  end

  # Atualiza a senha do usuário com base nos parâmetros fornecidos
  #
  # Se a atualização for bem-sucedida, redireciona para a página de login com uma mensagem de sucesso.
  # Caso contrário, renderiza a view de recuperação de senha com uma mensagem de erro.
  def update_password
    Rails.logger.debug params.inspect  # Adicione esta linha para depuração

    @user = User.find_by(usuario: params[:username])
    if @user.present? && params[:new_password] == params[:new_password_confirmation]
      if @user.update(senha: params[:new_password])
        redirect_to login_path, notice: 'Senha alterada com sucesso.'
      else
        flash.now[:alert] = 'Houve um problema ao alterar sua senha. Por favor, tente novamente.'
        render :recuperar_senha
      end
    else
      flash.now[:alert] = 'As senhas não coincidem ou usuário não encontrado.'
      render :recuperar_senha
    end
  end

  # Renderiza a view de criação de template
  def criar_templete
  end

  # Renderiza a view de resultados e define o breadcrumb e o valor
  def resultados
    @breadcrumb = "Gerenciamento - Resultados"
    @valor = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  end

  # Renderiza a view de avaliações e define o breadcrumb e o valor
  def avaliacoes
    @breadcrumb = 'Avaliação'
    @valor = [1,2,3,4,5,6,7,8,9,10]
  end

  # Renderiza a view de questionários e define o breadcrumb, pergunta, matéria e semestre
  def questionarios
    @breadcrumb = "Avaliação - Nome da Matéria - Semestre"
    @pergunta = "Pergunta"
    @materia = params[:materia]
    @semestre = params[:semestre]
    @text_pergunta = "Pergunta"
  end

  # Renderiza a view de gerenciamento e define o breadcrumb
  def gerenciamento
    @breadcrumb = "Gerenciamento"
  end

  # Renderiza a view de templates e define o breadcrumb e o valor
  def templates
    @breadcrumb = "Gerenciamento - Templates"
    @valor = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
  end

  # Importa dados de membros e disciplinas a partir de arquivos JSON
  #
  # Se nenhum arquivo for selecionado, define uma mensagem de erro.
  # Tenta processar os arquivos selecionados e define uma mensagem de sucesso ou erro.
  #
  # ==== Parâmetros
  # - +params[:file_membros]+ - Arquivo de membros a ser importado.
  # - +params[:file_disciplinas]+ - Arquivo de disciplinas a ser importado.
  def importar_dados
    @membros = params[:file_membros]
    @disciplinas = params[:file_disciplinas]

    if !@membros && !@disciplinas
      flash[:error] = "Nenhum arquivo foi selecionado."
    else
      begin
        verifica_membros(@membros)

        verifica_disciplinas(@disciplinas)

        flash[:success] = "Arquivos importados com sucesso."
      rescue => e
        flash[:error] = "Houve um erro ao importar os dados: #{e.message}"
      end
    end

    resposta_requisicao
  end

  private

  # Processa arquivos JSON, chamando o método de processamento adequado para cada arquivo
  #
  # ==== Parâmetros
  # - +files+ - Arquivo ou array de arquivos a serem processados.
  # - +process_method+ - Método de processamento a ser chamado para cada arquivo.
  def process_files(files, process_method)
    if files.is_a?(Array)
      files.each do |file|
        json_data = JSON.parse(file.read)
        process_method.call(json_data)
      end
    else
      json_data = JSON.parse(files.read)
      process_method.call(json_data)
    end
  end

  # Processa dados JSON de membros, criando ou atualizando usuários
  #
  # ==== Parâmetros
  # - +data+ - Dados JSON a serem processados.
  def process_json_data(data)
    data.each do |entry|
      docente = entry['docente']
      dicente = entry['dicente']

      process_user(docente) if docente
      dicente.each { |d| process_user(d) } if dicente
    end
  end

  # Processa dados de um usuário, criando ou atualizando a instância de User
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

  # Processa dados JSON de classes, criando ou atualizando instâncias de CourseClass
  #
  # ==== Parâmetros
  # - +data+ - Dados JSON a serem processados.
  def process_class_data(data)
    data.each do |class_entry|
      class_info = class_entry['class']
      course_class = CourseClass.find_or_initialize_by(code: class_entry['code'])
      course_class.assign_attributes(
        code: class_entry['code'],
        name: class_entry['name'],
        classCode: class_info['classCode'],
        semester: class_info['semester'],
        time: class_info['time']
      )
      course_class.save!
    end
  end

  def verifica_membros(membros)
    if membros
      process_files(membros, method(:process_json_data))
    end
  end

  def verifica_disciplinas(disciplinas)
    if disciplinas
      process_files(disciplinas, method(:process_json_data))
    end
  end

  def resposta_requisicao
    respond_to do |format|
      format.html { redirect_to users_path }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("popup-upload", partial: "shared/flash_messages") }
    end
  end
end
