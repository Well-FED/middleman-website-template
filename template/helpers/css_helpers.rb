module CssHelpers
  MINIFY_REPLACEMENTS = [
    [/\n/,                                ''],
    [%r{/\*[^*]*\*+(?:[^*/][^*]*\*+)*/},  ''],
    [/\s{2,}/,                           ' '],
    [/\s*\{\s*/,                         '{'],
    [/:\s{2,}/,                          ':'],
    [/;\s{2,}/,                          ';']
  ].freeze

  def minify_inline_css(css_string)
    MINIFY_REPLACEMENTS.inject(css_string) do |string, (pattern, replacement)|
      string.gsub(pattern, replacement)
    end
  end

  def inline_css(*names)
    names.map { |name| inline_style_tag(name) }.reduce(:+)
  end

  private

  def inline_style_tag(name)
    name += '.css' unless name.include?('.css')
    css = sitemap_resource(name).render
    "<style>#{minify_inline_css(css)}</style>"
  end

  def sitemap_resource(name)
    sitemap.resources.detect { |resource| resource.path == name }
  end
end
