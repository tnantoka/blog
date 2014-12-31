module PostsHelper
  def timeago(time)
    content_tag(:span, "#{time_ago_in_words(time)}#{t('shared.ago')}", title: time)
  end

  def draft_label(post)
    if post.template?
      content_tag(:span, t('shared.template'), class: 'label label-default')
    elsif !post.published?
      content_tag(:span, t('shared.draft'), class: 'label label-default')
    else
      nil
    end
  end

  def post_created(post)
    timeago(post.created_at)
  end

  def tweet_url(post)
    prefix = user_signed_in? ? "#{Settings.tweet.prefix}+" : ''
    suffix = user_signed_in? ? '' : "+#{Settings.tweet.suffix}" 
    text = "#{prefix}#{post.title}+-+#{Settings.site.title}+#{post_url(post)}#{suffix}"
    "https://twitter.com/intent/tweet?text=#{text}"
  end

  def identity_link(identity)
    link_to identity.nickname, identity.url
  end
end
