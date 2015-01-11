class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header || I18n.default_locale
  end

  def set_posts
    @posts = user_signed_in? ? Post.all : Post.published
    @toc = @posts.root.includes(:children)
  end

  def current_identity
    @current_identity ||= Identity.find_by(id: session[:identity_id])
  end
  helper_method :current_identity

  def current_identity=(identity)
    session[:identity_id] = identity.try(:id)
  end

  def authenticate_identity!
    head :unauthorized and return if current_identity.blank?
  end

  private
    def extract_locale_from_accept_language_header
      available_locale(request.env['HTTP_ACCEPT_LANGUAGE'].to_s.scan(/^[a-z]{2}/).first)
    end

    def available_locale(parsed_locale)
      I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    end
end
