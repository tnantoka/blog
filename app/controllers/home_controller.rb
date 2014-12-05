class HomeController < ApplicationController
  before_action :set_posts, only: [:index]

  def index
    @posts = @posts.latest.page(params[:page]).per(5)
  end
end
