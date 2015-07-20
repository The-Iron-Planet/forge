class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :first_login_setup, except: [:first_login, :update]
  before_action :set_user, only: [:show, :edit, :edit_password, :update, :destroy, :work_history]
  before_action :check_user, only: [:edit, :edit_password]
  before_action :user_is_cd?, only: [:new]

  # GET /users
  def index
    if request.post?
      @users = User.search_results(params[:query], params[:campus_id], params[:curric_id], params[:job_status]).ordered
      if @users == User
        @users = User.all.ordered
        flash.now[:notice] = "Please choose specific search parameters."
        render :index
      end
    else
      @users = User.all.ordered
    end
  end

  # GET /users/1
  def show
  end

  def dashboard
    @user = current_user
    @events = Event.where("happens_on >= ?", Time.zone.now.beginning_of_day).ordered.
      where(campus_id: current_user.campus_id)
    if @user.is_cd
      @job_posts = JobPost.all.ordered.all_active.first(5)
      @resources = Resource.all.ordered.first(3)
    elsif @user.is_instructor
      @job_posts = JobPost.all.ordered.where(curriculum_id: current_user.curriculum_id).all_active.first(5)
      @resources = Resource.all.ordered.where(curriculum_id: current_user.curriculum_id).first(3)
    else
      @job_posts = JobPost.ordered.where(curriculum_id: current_user.curriculum_id).all_active.first(5)
      @resources = Resource.ordered.where(curriculum_id: current_user.curriculum_id).first(5)
    end

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def work_history
    @user.positions.build
  end

  def edit_password
  end

  def first_login
    @user = current_user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.password = "theironyard"
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.sign_in_count > 1
      if @user.update(user_params)
        # Sign in the user by passing validation in case their password changed
        sign_in :user, @user, bypass: true
        respond_to do |format|
          format.html { redirect_to user_path, notice: 'User was successfully updated.' }
          format.js { redirect_to work_history_path(@user), notice: 'Work History was successfully updated.' }
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.js { render :work_history }
        end
      end
    else
      @user.sign_in_count += 1
      if @user.update(user_params)
        # Sign in the user by passing validation in case their password changed
        sign_in :user, @user, bypass: true
        redirect_to user_path, notice: 'User was successfully updated.'
      else
        render :first_login
      end
    end
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      sign_in :user, @user, bypass: true
      redirect_to @user, notice: 'Password was successfully updated'
    else
      flash.now[:notice] = 'Current password was invalid. Please try again'
      render :edit_password
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def first_login_setup
      redirect_to first_login_path if current_user.sign_in_count < 2
    end

    def set_user
      @user = User.find_by_id(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:id, :uploaded_file, :first_name, :last_name,
          :current_city, :current_state, :github_profile, :twitter, :slack_handle, :website, :blog,
          :looking, :hiring, :is_cd, :is_instructor, :is_mentor, :course_id, :campus_id, :curriculum_id, :email,
          :password, :password_confirmation, :current_password, :get_event_email, :campus_notification_id,
          :get_job_email, :get_resource_email, :get_comment_email, positions_attributes:
            [:id, :user_id, :company_name, :title, :city, :state, :started_on, :ended_on, :current])
    end

    def check_user
      redirect_to root_path, notice: "You can only edit your own profile!" unless @user.id == current_user.id
    end
end
