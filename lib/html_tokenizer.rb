require_relative "element"
require_relative "doctype"
require_relative "mark"

class HtmlTokenizer

  def initialize(file)
    @file = file
  end

  def getNextToken
    if @file.eof? then
      return nil
    end
    firstChar = @file.getc
    @file.ungetc(firstChar)
    if firstChar == "<" then
      @file.gets(">")
    else
      text = @file.gets("<")
      if text.end_with?("<") then
        @file.ungetc("<")
      end
      striped = text.split("<")[0].strip
      if striped.empty? then
        getNextToken
      else
        striped
      end
    end
  end

  def getNextElement
    token = getNextToken
    if token == nil then
      nil
    elsif not token.start_with?("<") or token.start_with?("<![CDATA") or token.start_with?("<!]]>") then
      CData.new(token)
    elsif token.start_with?("<!DOCTYPE") then
      Doctype.new(token)
    elsif token.start_with?("<!--") or token.start_with?("<!") then
      Comment.new(token)
    else
      Mark.new(token)
    end
  end

end
