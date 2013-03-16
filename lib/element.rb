class Element
  def initialize(content)
    @content = content
  end

  def content
    @content
  end

  def ==(element)
    if element == nil
      false
    else
      @content == element.content
    end
  end

  def isDoctype
    false
  end

  def isMark
    false
  end

  def isValid
    false
  end

  def isComment
    false
  end

  def isCData
    false
  end

end

class CData < Element
  def getName
    "CData"
  end

  def isCData
    true
  end
end

class Comment < Element
  def getName
    "Comment"
  end

  def isComment
    true
  end
end