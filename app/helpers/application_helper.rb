module ApplicationHelper
  def home_page?
    controller_name == 'home' && action_name == 'index'
  end

  def posts_page?
    controller_name == 'posts' && action_name == 'index'
  end

  def new_post_page?
    controller_name == 'posts' && action_name == 'new'
  end

  def post_page?
    controller_name == 'posts' && action_name == 'show'
  end

  def attachments_page?
    controller_name == 'attachments' && action_name == 'index'
  end

  def with_toc?
    home_page? || post_page?
  end
end
