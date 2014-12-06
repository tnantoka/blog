class VersionsController < ApplicationController
  before_action :set_posts
  before_action :set_post

  def index
    @versions = @post.versions.includes(:item).latest.page(params[:page])
    if @versions.current_page == 1
      @current = Version.current(@post)
    end
  end

  def show
    @version = @post.versions.find(params[:id])
  end

  def current
    @version = Version.current(@post)
    render :show
  end

  private
    def set_post
      @post = @posts.find(params[:post_id])
    end
end
