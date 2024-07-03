class PagesController < ApplicationController
  def login
    # Renderiza a view de login
  end

  def home
    # Renderiza a view de home
  end

  def recuperar_senha
    @username = params[:username]
  end


  def update_password
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


  def criar_templete
    # Renderiza a view de criação de templete
  end

  def resultados
    @breadcrumb = "Gerenciamento - Resultados"

    @valor = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  end

  def avaliacoes
    @breadcrumb = 'Avaliação'

    @valor = [1,2,3,4,5,6,7,8,9,10]
  end

  def questionarios
    @breadcrumb = "Avaliação - Nome da Matéria - Semestre"

    @pergunta = "Pergunta"
    @materia = params[:materia]
    @semestre = params[:semestre]

    @text_pergunta = "Pergunta"
  end

  def gerenciamento
    @breadcrumb = "Gerenciamento"
  end


  def importar_dados
    @membros = params[:file_membros]
    @disciplinas = params[:file_disciplinas]
    if !@membros and !@disciplinas
      flash[:error] = "Nenhum arquivo foi selecionado."
    end
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

      if @disciplinas
        if @disciplinas.is_a?(Array)
          @disciplinas.each do |file|
            json_data = JSON.parse(file.read)
            process_json_data(json_data)
          end
        else
          # Se for apenas um único arquivo
          json_data = JSON.parse(@disciplinas.read)
          process_json_data(json_data)
        end
      end

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

      if docente
        # Processa o docente
        process_user(docente)

      elsif dicente
        # Processa os dicentes
        dicente.each { |d| process_user(d) }
      else
        entry.each {|disciplina| process_class(disciplina)}

      end
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

  def process_class(class_data)
    class_name = Class.find_or_initialize_by(code:class_data['code'])
    class_name.assign_attributes(

    )
    class_name.save!
  end
end
