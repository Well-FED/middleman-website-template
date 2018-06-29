module PropertyHelpers
  PROPERTIES = {
    page_title:       'title',
    page_description: 'description',
    page_image_url:   'image_url',
    page_type:        'type'
  }.freeze

  def property_lookup(key)
    PROPERTIES[key.to_sym]
  end

  # If the key exists in the current_page.data hash (YAML Frontmatter)
  # then return that, otherwise use the fallback key
  def get_page_value(key, default_value = nil)
    return default_value if current_page.nil?
    current_page.data[key] || current_page.data[property_lookup(key)]
  end

  def get_site_value(key)
    data.site[property_lookup(key)]
  end

  # If the key is set using a content_for, then yield_content on that key,
  # else fallback to the default_value
  def yield_if_set(key, default_value = nil)
    (yield_content(key) if content_for?(key)) || default_value
  end

  # Three-tier fallback:
  # 1. if content_for? then yield_content
  # 2. Else try current_page.data
  # 3. Else fallback to data.site
  def fallback_string(key)
    yield_if_set(key, get_page_value(key, get_site_value(key)))
  end

  # e.g. "About us | Acme Inc."
  def get_title
    "#{fallback_string(:page_title)} | #{data.site.name}"
  end
end
