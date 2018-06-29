module PageHelpers
  def get_page_class
    "page_#{class_string(current_page)}"
  end

  private

  def class_string(page)
    page.url == '/' ? 'home' : page.url.parameterize
  end
end
