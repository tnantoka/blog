class MarkdownRenderer
  class << self
    def renderer_options
      {
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
    end

    def renderer
      Redcarpet::Render::HTML.new(renderer_options)
    end

    def toc_renderer
      Redcarpet::Render::HTML_TOC.new(renderer_options)
    end

    def markdown(renderer)
      Redcarpet::Markdown.new(renderer,
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
        footnotes: true,
      )
    end

    def render(content)
      markdown(renderer).render(content.to_s)
    end

    def toc(content)
      markdown(toc_renderer).render(content.to_s)
    end
  end
end

