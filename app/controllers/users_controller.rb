class UsersController < ApplicationController
  before_action :authenticate_user!

  before_action :set_user, only: [:show, :edit, :edit_password, :update, :destroy]
  before_action :check_user, only: [:edit, :edit_password]
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

  def edit_password
    @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
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
    def set_user
      @user = User.find_by_id(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:id, :uploaded_file, :first_name, :last_name,
          :current_city, :current_state, :github_profile, :website, :blog,
          :looking, :hiring, :is_cd, :course_id, :email, :password,
          :password_confirmation, :current_password)
    end

    def check_user
      redirect_to root_path, notice: "You can only edit your own profile!" unless @user.id == current_user.id
    end
end
