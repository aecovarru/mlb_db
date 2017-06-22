module Download
  extend self
  def download_file(url)
    puts url
    return Nokogiri::HTML(open(url))
  end

  def table_data(doc, css)
    rows = doc.css(css).map {|element| NokogiriParser.new(element)}
    return rows
  end
end

