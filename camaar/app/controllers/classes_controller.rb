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
      if @class.save
        format.html { redirect_to class_url(@class), notice: "Class was successfully created." }
        format.json { render :show, status: :created, location: @class }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classes/1 or /classes/1.json
  def update
    respond_to do |format|
      if @class.update(class_params)
        format.html { redirect_to class_url(@class), notice: "Class was successfully updated." }
        format.json { render :show, status: :ok, location: @class }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @class.errors, status: :unprocessable_entity }
      end
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
end
