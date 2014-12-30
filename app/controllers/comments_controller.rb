class CommentsController < ApplicationController
  before_action :authenticate_identity!
  before_action :set_posts
  before_action :set_post

  def create
    @comment = current_identity.comments.new(comment_params) 
    @comment.post = @post
    if @comment.save
      redirect_to @post, notice: t('flash.created', model: Comment.model_name.human)
    else
      @comments = @post.comments.includes(:identity)
      render 'posts/show'
    end
  end

  private
    def set_post
      @post = @posts.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
