class IdentitiesController < ApplicationController
  def new
    session[:post_id] = params[:post_id]
    redirect_to '/auth/github'
  end

  def create
    identity = Identity.find_or_create_from_auth_hash(auth_hash)
    self.current_identity = identity
    post = Post.find(session[:post_id])
    redirect_to post, notice: t('devise.sessions.signed_in')
  end

  def destroy
    self.current_identity = nil
    sign_out(current_user) if user_signed_in?
    redirect_to :back, notice: t('devise.sessions.signed_out')
  end

  private
    def auth_hash
      request.env['omniauth.auth']
    end
end
