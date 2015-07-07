class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit]
  before_action :user_is_cd?, only: [:new]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.password = "password"

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_id(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:id, :uploaded_file, :first_name, :last_name,
          :current_city, :current_state, :github_profile, :website, :blog,
          :looking, :hiring, :is_cd, :course_id, :email, :password, :password_confirmation)
    end

    def check_user
      redirect_to root_path, notice: "You can only edit your own profile!" unless @user.id == current_user.id
    end
end
