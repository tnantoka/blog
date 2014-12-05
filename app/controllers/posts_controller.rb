class PostsController < ApplicationController
  before_action :set_posts, only: [:show, :edit, :update, :destroy, :index, :search, :published, :draft, :template]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_templates, only: [:new, :create, :edit, :update]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :preview, :published, :draft, :template]

  def index
    @posts = @posts.latest.page(params[:page])
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to @post, notice: t('flash.created', model: Post.model_name.human)
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('flash.updated', model: Post.model_name.human)
    else
      render :edit 
    end
  end

  def destroy
    @post.destroy
    redirect_to :posts, notice: t('flash.destroyed', model: Post.model_name.human)
  end

  def search
    query = params[:q].to_s.strip
    @posts = @posts.search(query) if query.present?
    @posts = @posts.page(params[:page])
  end

  def preview
    @post = Post.new(post_params)
    render json: {
      title: @post.title,
      content: @post.render,
      count: @post.count,
    }
  end

  def published
    @posts = @posts.published.latest.page(params[:page])
    render :index
  end

  def draft
    @posts = @posts.draft.latest.page(params[:page])
    render :index
  end

  def template
    @posts = @posts.template.latest.page(params[:page])
    render :index
  end

  private
    def set_post
      @post = @posts.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :published, :template)
    end

    def set_templates
      @templates = Post.template.latest
    end
end
