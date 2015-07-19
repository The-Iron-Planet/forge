class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :user_is_cd?
  before_action :set_course, only: [:show, :edit, :update, :destroy, :add_students]

  # GET /courses
  def index
    @course = Course.new
    @courses = Course.all
  end

  # GET /courses/1
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    @course.users.build
  end

  def add_students
    @course.users.build
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_path, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /courses/1
  def update
    unless params[:course][:users_attributes] == nil
      params[:course][:users_attributes].each do |k, v|
        v[:password] = "theironyard" unless v[:id]
      end
    end
    if @course.update(course_params)
      respond_to do |format|
        format.html { redirect_to courses_path, notice: 'Course was successfully updated.'}
        format.js { redirect_to add_students_path(@course), notice: 'Student was successfully added.' }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.js { redirect_to add_students_path }
      end
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit(:started_on, :ended_on, :campus_id, :curriculum_id,
          users_attributes: [:id, :first_name, :last_name, :email, :password, :campus_id, :curriculum_id])
    end
end
