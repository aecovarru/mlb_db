class NokogiriParser
  attr_accessor :element
  def initialize(element)
    @element = element
  end

  def identity
	  href = element.child.child['href']
	  href = element.child['href'] unless href
    href[11..href.index(".")-1]
  end

  def text
    element.text
  end

  def to_i
    text.to_i
  end

  def thou_i
    (text.to_f*1000).to_i
  end

  def to_f
    text[0...-2].to_f
  end

  def date
    href = element.child['href'] if href
    begin
      Date.parse(href[-10..-1]) if href
    rescue ArgumentError
    end
  end

  def num
    children = element.children
    children.size == 1 ? 0 : children.last.to_s[-2].to_i
  end

  def fangraph_id
	  href = element.child['href']
	  if href
			first = href.index('=')+1
		  last = href.index('&')
		  return href[first...last].to_i
	  end
  end

  def fangraph_name
    element.child.child.to_s
  end
end
