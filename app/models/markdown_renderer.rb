class MarkdownRenderer
  class << self
    RENDERER_OPTIONS = {
      filter_html: false,
      no_images: false,
      no_links: false,
      no_styles: false,
      escape_html: true,
      safe_links_only: false,
      with_toc_data: true,
      hard_wrap: true,
      xhtml: false,
      prettify: true,
      link_attributes: {
        target: '_blank'
      }
    }

    MARKDOWN_OPTIONS = {
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
      disable_indented_code_blocks: true,
      strikethrough: true,
      lax_spacing: true,
      space_after_headers: true,
      superscript: true,
      underline: true,
      highlight: true,
      quote: false,
      footnotes: true
    }

    def markdown
      @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(RENDERER_OPTIONS), MARKDOWN_OPTIONS)
    end

    def toc_markdown
      @toc_markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC.new(RENDERER_OPTIONS), MARKDOWN_OPTIONS)
    end

    def render(content)
      markdown.render(content.to_s)
    end

    def toc(content)
      toc_markdown.render(content.to_s)
    end
  end
end

