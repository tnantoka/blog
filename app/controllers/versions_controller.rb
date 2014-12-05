class VersionsController < ApplicationController
  before_action :set_posts
  before_action :set_post

  def index
    @versions = @post.versions.includes(:item).latest.page(params[:page])
  end

  def show
    @version = @post.versions.find(params[:id])
  end

  private
    def set_post
      @post = @posts.find(params[:post_id])
    end
end
