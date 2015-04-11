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

  def footer_link(link)
    label = link.label.presence || eval(link.label_ruby)
    url = link.url.presence || eval(link.url_ruby)
    link_to label.html_safe, url, class: 'link-plain'
  end
end
