require_relative "html_validator"
require_relative "html_tokenizer"
require_relative "html_rules"
require_relative "element"
require_relative "mark"
require_relative "doctype"

validator = HtmlValidator.new(HtmlRules.new)
if validator.validate(File.new(ARGV[0])) then
  puts "Passed"
else
  puts "Errors"
end