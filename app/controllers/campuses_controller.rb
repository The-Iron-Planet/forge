class CampusesController < ApplicationController
  before_action :authenticate_user!
  before_action :user_is_cd?
  before_action :set_campus, only: [:show, :edit, :update, :destroy]

  # GET /campuses
  def index
    @campuses = Campus.all
  end

  # GET /campuses/1
  def show
  end

  # GET /campuses/new
  def new
    @campus = Campus.new
  end

  # GET /campuses/1/edit
  def edit
  end

  # POST /campuses
  def create
    @campus = Campus.new(campus_params)

    if @campus.save
      redirect_to new_course_path, notice: 'Campus was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /campuses/1
  def update
    if @campus.update(campus_params)
      redirect_to @campus, notice: 'Campus was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /campuses/1
  def destroy
    @campus.destroy
    redirect_to campuses_url, notice: 'Campus was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campus
      @campus = Campus.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def campus_params
      params.require(:campus).permit(:city, :state)
    end
end
