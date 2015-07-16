class Resources::CommentsController < CommentsController
  before_action :set_commentable

  private
    def set_commentable
      @commentable = Resource.find(params[:resource_id])
    end
end
