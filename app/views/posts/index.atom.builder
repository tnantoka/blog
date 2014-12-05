atom_feed do |feed|
  feed.title(Settings.site.title)
  feed.updated(@posts.first.created_at) if @posts.present?

  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content(post.render, type: 'html')

      entry.author do |author|
        author.name(Settings.copyright.label)
      end
    end
  end
end
