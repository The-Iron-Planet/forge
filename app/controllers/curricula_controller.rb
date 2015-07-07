class CurriculaController < ApplicationController
  before_action :set_curriculum, only: [:show, :edit, :update, :destroy]

  # GET /curricula
  def index
    @curricula = Curriculum.all
  end

  # GET /curricula/1
  def show
  end

  # GET /curricula/new
  def new
    @curriculum = Curriculum.new
  end

  # GET /curricula/1/edit
  def edit
  end

  # POST /curricula
  def create
    @curriculum = Curriculum.new(curriculum_params)

    if @curriculum.save
      redirect_to @curriculum, notice: 'Curriculum was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /curricula/1
  def update
    if @curriculum.update(curriculum_params)
      redirect_to @curriculum, notice: 'Curriculum was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /curricula/1
  def destroy
    @curriculum.destroy
    redirect_to curricula_url, notice: 'Curriculum was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curriculum
      @curriculum = Curriculum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def curriculum_params
      params.require(:curriculum).permit(:name)
    end
end
