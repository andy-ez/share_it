module ApplicationHelper
  def fix_url(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end

  def date_format(dt)
    dt.strftime('%d/%m/%Y %l:%M%P %Z')
  end

end
