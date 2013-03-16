require_relative "element"

class Doctype < Element
  HTML5_DOCTYPE = "<!DOCTYPE HTML>".upcase
  HTML401_STRICT_DOCTYPE = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">".upcase
  HTML401_TRANSITIONAL_DOCTYPE = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN<\" \"http://www.w3.org/TR/html4/loose.dtd\">".upcase
  HTML401_FRAMESET_DOCTYPE = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\" \"http://www.w3.org/TR/html4/frameset.dtd\">".upcase
  DOCTYPES = [HTML5_DOCTYPE, HTML401_STRICT_DOCTYPE, HTML401_TRANSITIONAL_DOCTYPE, HTML401_FRAMESET_DOCTYPE]

  def initialize(content)
    @content = content.upcase
  end

  def isDoctype
    true
  end

  def isValid
    DOCTYPES.each {|d|
      if d == @content then
        return true
      end
     }
  end
end
