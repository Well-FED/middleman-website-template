module CustomHelpers

  # Inline CSS for the <head> on the homepage
  # =================================================
  def minify_inline_css css_string
    rLineBreaks = /\n/
    rCSSComments = /\/\*[^*]*\*+(?:[^*\/][^*]*\*+)*\//
    rExtraSpaces = / +/
    rOpenBrackets = / \{ /
    rColons = /: /
    rSemiColons = /; /
    css_string.to_s.gsub(rCSSComments,'').gsub(rLineBreaks,'').gsub(rExtraSpaces,' ').gsub(rOpenBrackets, '{').gsub(rColons, ':').gsub(rSemiColons, ';')
  end

  def inline_css(*names)
    names.map { |name|
      name += ".css" unless name.include?(".css")
      css_path = sitemap.resources.select { |p| p.path == name }.first
      outputCSS = minify_inline_css(css_path.render)
      "<style>#{outputCSS}</style>"
    }.reduce(:+)
  end

  # Property setting on a per-page or site-wide basis
  # =================================================
  def property_lookup key
    lookup = {
      :page_title => 'title',
      :page_description => 'description',
      :page_image_url => 'image_url',
      :page_type => 'type'
    }
    return lookup[key]
  end

  def get_page_value key, default_value = nil
    return default_value if current_page.nil?

    # If the key exists in the current_page.data hash (YAML Frontmatter) then return that
    return current_page.data[key] unless current_page.data[key].nil?

    # If the key exists in the current_page.data hash using the fallback key
    return current_page.data[property_lookup(key)]
  end

  def get_site_value key
    return data.site[property_lookup(key)]
  end

  def yield_if_set(key, default_value = nil)
    # If the key is set using a content_for, then yield_content on that key,
    # else fallback to the default_value
    (yield_content(key) if content_for?(key)) || default_value
  end

  def fallback_string key
    # Three-tier fallback:
    # 1. if content_for? then yield_content
    # 2. Else try current_page.data
    # 3. Else fallback to data.site
    yield_if_set(key, get_page_value(key, get_site_value(key)))
  end

  def get_title
    # e.g. "About us | Acme Inc."
    return "#{fallback_string(:page_title)} | #{data.site.name}"
  end

  # Class settings
  # =================================================
  def get_page_class
    class_string = "home"
    if current_page.url != "/"
      class_string = current_page.url.parameterize
    end
    return "page_#{class_string}"
  end

end
