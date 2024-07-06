class ClassesController < ApplicationController
  before_action :set_class, only: %i[ show edit update destroy ]

  # GET /classes or /classes.json
  def index
    @classes = Class.all
  end

  # GET /classes/1 or /classes/1.json
  def show
  end

  # GET /classes/new
  def new
    @class = Class.new
  end

  # GET /classes/1/edit
  def edit
  end

  # POST /classes or /classes.json
  def create
    @class = Class.new(class_params)

    respond_to do |format|
      html = format.html
      json = format.json

      save_class(@class, html, json)
    end
  end

  # PATCH/PUT /classes/1 or /classes/1.json
  def update
    respond_to do |format|
      html = format.html
      json = format.json

      update_class(@class, html, json)
    end
  end

  # DELETE /classes/1 or /classes/1.json
  def destroy
    @class.destroy!

    respond_to do |format|
      format.html { redirect_to classes_url, notice: "Class was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class
      @class = Class.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def class_params
      params.require(:class).permit(:code, :name, :classCode, :semester, :time)
    end

    def save_class(classe, html, json)
      if classe.save
        html { redirect_to class_url(classe), notice: "Class was successfully created." }
        json { render :show, status: :created, location: classe }
      else
        html { render :new, status: :unprocessable_entity }
        json { render json: classe.errors, status: :unprocessable_entity }
      end
    end

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
