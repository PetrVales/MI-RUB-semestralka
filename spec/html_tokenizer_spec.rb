require "rspec"
require_relative "../lib/html_tokenizer"
require_relative "../lib/element"
require_relative "../lib/mark"

describe "HtmlTokenizer" do

  it "should parse testFile.html into string tokens" do
    tokenizer = HtmlTokenizer.new(File.new("./resources/spec/testFile.html"))
    tokenizer.getNextToken.should eq "<!DOCTYPE html>"
    tokenizer.getNextToken.should eq "<html>"
    tokenizer.getNextToken.should eq "<head>"
    tokenizer.getNextToken.should eq "<title>"
    tokenizer.getNextToken.should eq "Hello HTML"
    tokenizer.getNextToken.should eq "</title>"
    tokenizer.getNextToken.should eq "</head>"
    tokenizer.getNextToken.should eq "<body>"
    tokenizer.getNextToken.should eq "<!-- comment -->"
    tokenizer.getNextToken.should eq "<p>"
    tokenizer.getNextToken.should eq "Hello World!"
    tokenizer.getNextToken.should eq "</p>"
    tokenizer.getNextToken.should eq "</body>"
    tokenizer.getNextToken.should eq "</html>"
    tokenizer.getNextToken.should eq nil
  end

  it "should parse testFile.html into elements" do
    tokenizer = HtmlTokenizer.new(File.new("./resources/spec/testFile.html"))
    tokenizer.getNextElement.should eq Doctype.new("<!DOCTYPE html>")
    tokenizer.getNextElement.should eq Mark.new("<html>")
    tokenizer.getNextElement.should eq Mark.new("<head>")
    tokenizer.getNextElement.should eq Mark.new("<title>")
    tokenizer.getNextElement.should eq CData.new("Hello HTML")
    tokenizer.getNextElement.should eq Mark.new("</title>")
    tokenizer.getNextElement.should eq Mark.new("</head>")
    tokenizer.getNextElement.should eq Mark.new("<body>")
    tokenizer.getNextElement.should eq Comment.new("<!-- comment -->")
    tokenizer.getNextElement.should eq Mark.new( "<p>")
    tokenizer.getNextElement.should eq CData.new("Hello World!")
    tokenizer.getNextElement.should eq Mark.new("</p>")
    tokenizer.getNextElement.should eq Mark.new("</body>")
    tokenizer.getNextElement.should eq Mark.new("</html>")
    tokenizer.getNextElement.should eq nil
  end

end

