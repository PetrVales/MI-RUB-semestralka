require_relative "element"

class Mark < Element
  def initialize(content)
    @content = content
    @contentRevered = @content.reverse
    if @content.start_with?("</") then
      @tag = @content.downcase.split("</")[1].split(">")[0].split(" ")[0].to_sym
      @parts = @content.downcase.split("</")[1].split(">")[0].split("=\"")
    elsif @contentRevered.start_with?(">/") then
      @tag = @content.downcase.split("<")[1].split("/>")[0].split(" ")[0].to_sym
      @parts = @content.downcase.split("<")[1].split("/>")[0].split("=\"")
    else
      @tag = @content.downcase.split("<")[1].split(">")[0].split(" ")[0].to_sym
      @parts = @content.downcase.split("<")[1].split(">")[0].split("=\"")
    end
    @attrs = Hash.new
    for i in 0..(@parts.length - 2) do
      attr = @parts[i].match("[^ ]*$")[0].to_sym
      @attrs[attr] = @parts[i + 1].match("^.*\"")[0].gsub("\"", "")
    end
  end

  def isMark
    true
  end

  def isTag(tag)
    @tag == tag
  end

  def isValid
    @content.start_with?("<") and @contentRevered.start_with?(">")
  end

  def getAttributes
    @attrs.keys
  end

  def getAttributeValue(attr)
    @attrs[attr]
  end

  def hasAttribute(attr)
    @attrs.key?(attr)
  end

  def isClose
    @content.start_with?("</") or @contentRevered.start_with?(">/")
  end

  def isOpen
    not @content.start_with?("</")
  end

  def getName
    @tag
  end

end