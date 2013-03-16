require_relative "html_tokenizer"

class HtmlValidator
  def initialize(htmlRules)
    @htmlRules = htmlRules
  end

  def validate(file)
    tokenizer = HtmlTokenizer.new(file)
    token = tokenizer.getNextElement
    if not token.isDoctype or not token.isValid then
      puts "invalid doctype"
      return false
    end
    token = getNextInterestingToken(tokenizer)
    if not token.isMark or not token.isTag(:html) or not token.isValid then
      puts "no html tag"
      return false
    end
    parents = [].push(token)
    while token = getNextInterestingToken(tokenizer) do
      if not @htmlRules.checkChildAllowed(parents.last, token) or not @htmlRules.checkAttributes(token) then
        return false
      end
      if token.isMark and token.isOpen then
        parents.push(token)
      end
      if token.isMark and token.isClose then
        parents.pop
      end
    end
    true
  end

  private
  def getNextInterestingToken(tokenizer)
    token = tokenizer.getNextElement
    if token == nil then
      nil
    elsif token.isComment then
      getNextInterestingToken(tokenizer)
    else
      token
    end
  end

end