class ResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :destroy]


  # GET /resources
  def index
    if request.post?
      @resources = Resource.ordered.search_results(params[:query])
      if @resources.blank?
        flash.now[:notice] = "Your search returned no results. Please try again."
      elsif @resources == Resource
        @resources = Resource.ordered.first(5)
        flash.now[:notice] = "Please choose specific search parameters."
        render :index
      end
    else
      @resources = Resource.ordered.first(5)
    end
    @resource = Resource.new
  end

  def my_resources
    @resources = Resource.where(user_id: current_user.id)
  end

  # GET /resources/new
  def new
    @resource = Resource.new
  end

  # GET /resources/1
  def show
    @comment = Comment.new
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  def create
    @resource = Resource.new(resource_params)
    @resource.user_id = current_user.id
    if @resource.save
      redirect_to resources_path, notice: 'Resource was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /resources/1
  def update
    if @resource.update(resource_params)
      redirect_to resources_path, notice: 'Resource was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /resources/1
  def destroy
    @resource.destroy
    redirect_to resources_path, notice: 'Resource was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Resource.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def resource_params
      params.require(:resource).permit(:title, :description, :website, :user_id,
          :curriculum_id)
    end

    def check_user
      redirect_to root_path, notice: "You can only edit your own resources!" unless @resource.user_id == current_user.id
    end
end
