# == ClassesController
#
# Este controlador é responsável por gerenciar as ações CRUD para a model Class.
#
# === Filtros
# - before_action :set_class, apenas: %i[show edit update destroy]
#
# === Ações Públicas
#
# - index
# - show
# - new
# - edit
# - create
# - update
# - destroy
#
# === Métodos Privados
# - set_class
# - class_params
# - save_class
# - update_class
#
# === Exemplos de uso
#
# Este controlador permite a criação, visualização, edição e exclusão de objetos da model Class.
#
# ==== Exemplo de Rotas
#
# GET /classes
# GET /classes/:id
# GET /classes/new
# GET /classes/:id/edit
# POST /classes
# PATCH/PUT /classes/:id
# DELETE /classes/:id

class ClassesController < ApplicationController
  before_action :set_class, only: %i[ show edit update destroy ]

  # GET /classes or /classes.json
  #
  # Retorna todas as instâncias da model Class.
  #
  # ==== Exemplo de resposta
  #
  #   [
  #     { id: 1, name: 'Class A', ... },
  #     { id: 2, name: 'Class B', ... }
  #   ]
  #
  def index
    @classes = Class.all
  end

  # GET /classes/1 or /classes/1.json
  #
  # Retorna uma instância específica da model Class baseada no ID fornecido.
  #
  def show
  end

  # GET /classes/new
  #
  # Retorna uma nova instância da model Class para criação.
  #
  def new
    @class = Class.new
  end

  # GET /classes/1/edit
  #
  # Retorna uma instância específica da model Class para edição baseada no ID fornecido.
  #
  def edit
  end

  # POST /classes or /classes.json
  #
  # Cria uma nova instância da model Class com os parâmetros fornecidos.
  #
  # ==== Parâmetros
  #
  # - +class_params+ - Parâmetros permitidos para a criação da model Class.
  #
  # ==== Exemplo de resposta
  #
  # - HTML: Redireciona para a visualização da nova instância criada.
  # - JSON: Retorna a nova instância criada com status :created.
  #
  def create
    @class = Class.new(class_params)

    respond_to do |format|
      html = format.html
      json = format.json

      save_class(@class, html, json)
    end
  end

  # PATCH/PUT /classes/1 or /classes/1.json
  #
  # Atualiza uma instância específica da model Class com os parâmetros fornecidos.
  #
  # ==== Parâmetros
  #
  # - +class_params+ - Parâmetros permitidos para a atualização da model Class.
  #
  # ==== Exemplo de resposta
  #
  # - HTML: Redireciona para a visualização da instância atualizada.
  # - JSON: Retorna a instância atualizada com status :ok.
  #
  def update
    respond_to do |format|
      html = format.html
      json = format.json

      update_class(@class, html, json)
    end
  end

  # DELETE /classes/1 or /classes/1.json
  #
  # Exclui uma instância específica da model Class baseada no ID fornecido.
  #
  # ==== Exemplo de resposta
  #
  # - HTML: Redireciona para a lista de instâncias da model Class com uma mensagem de sucesso.
  # - JSON: Retorna status :no_content.
  #
  def destroy
    @class.destroy!

    respond_to do |format|
      format.html { redirect_to classes_url, notice: "Class was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Seta a instância da model Class baseada no ID fornecido em determinados filtros de ação.
  #
  # ==== Exemplo
  #
  #   set_class
  #
  def set_class
    @class = Class.find(params[:id])
  end

  # Permite uma lista de parâmetros confiáveis para a criação e atualização da model Class.
  #
  # ==== Parâmetros permitidos
  #
  # - +:code+
  # - +:name+
  # - +:classCode+
  # - +:semester+
  # - +:time+
  #
  def class_params
    params.require(:class).permit(:code, :name, :classCode, :semester, :time)
  end

  # Salva uma nova instância da model Class e define as respostas para HTML e JSON.
  #
  # ==== Parâmetros
  #
  # - +classe+ - A instância da model Class a ser salva.
  # - +html+ - Bloco de resposta para formato HTML.
  # - +json+ - Bloco de resposta para formato JSON.
  #
  def save_class(classe, html, json)
    if classe.save
      html { redirect_to class_url(classe), notice: "Class was successfully created." }
      json { render :show, status: :created, location: classe }
    else
      html { render :new, status: :unprocessable_entity }
      json { render json: classe.errors, status: :unprocessable_entity }
    end
  end

  # Atualiza uma instância da model Class e define as respostas para HTML e JSON.
  #
  # ==== Parâmetros
  #
  # - +classe+ - A instância da model Class a ser atualizada.
  # - +html+ - Bloco de resposta para formato HTML.
  # - +json+ - Bloco de resposta para formato JSON.
  #
  def update_class(classe, html, json)
    if classe.update(class_params)
      html { redirect_to class_url(classe), notice: "Class was successfully updated." }
      json { render :show, status: :ok, location: classe }
    else
      html { render :edit, status: :unprocessable_entity }
      json { render json: classe.errors, status: :unprocessable_entity }
    end
  end
end
