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

    if !@membros && !@disciplinas
      flash[:error] = "Nenhum arquivo foi selecionado."
    else
      begin
        if @membros
          process_files(@membros, method(:process_json_data))
        end

        if @disciplinas
          process_files(@disciplinas, method(:process_class_data))
        end

        flash[:success] = "Arquivos importados com sucesso."
      rescue => e
        flash[:error] = "Houve um erro ao importar os dados: #{e.message}"
      end
    end

    respond_to do |format|
      format.html { redirect_to users_path }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("popup-upload", partial: "shared/flash_messages") }
    end
  end

  private

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

  def process_json_data(data)
    data.each do |entry|
      docente = entry['docente']
      dicente = entry['dicente']

      process_user(docente) if docente
      dicente.each { |d| process_user(d) } if dicente
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

end
