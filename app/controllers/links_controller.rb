class LinksController < ApplicationController
  before_action :authenticate_user!

  def create
    url = params[:url]
    title = Link.fetch_title(url)
    render json: {
      url: url,
      title: title
    }
  end
end
