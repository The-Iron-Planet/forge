class JobPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job_post, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit]

  # GET /job_posts
  def index
    if request.post?
      @job_posts = JobPost.ordered.search_results(params[:query], params[:experience_desired],
        params[:curriculum_id])
      if @job_posts.blank?
        flash.now[:notice] = "Your search did not return any results. Please try again."
        render :index
      elsif @job_posts == JobPost
        @job_posts = JobPost.ordered.all_active
        flash.now[:notice] = "Please choose specific search parameters."
      end
    else
      @job_posts = JobPost.ordered.all_active
    end
  end

  def my_job_posts
    @job_posts = JobPost.ordered.where(user_id: current_user.id)
  end
  # GET /job_posts/new
  def new
    @job_post = JobPost.new
  end

  # GET /job_posts/1/edit
  def edit
  end

  # POST /job_posts
  def create
    @job_post = JobPost.new(job_post_params)
    @job_post.user_id = current_user.id
    @job_post.active = true
    if @job_post.save
      redirect_to job_posts_path, notice: 'Job post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /job_posts/1
  def update
    if @job_post.update(job_post_params)
      redirect_to job_posts_path, notice: 'Job post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /job_posts/1
  def destroy
    @job_post.destroy
    redirect_to job_posts_url, notice: 'Job post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_post
      @job_post = JobPost.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_post_params
      params.require(:job_post).permit(:company_name, :city, :state, :user_id, :curriculum_id,
          :title, :description, :experience_desired, :website, :expires_on, :active)
    end

    def check_user
      redirect_to root_path, notice: "You can only edit your own job posts!" unless @job_post.user_id == current_user.id
    end
end
