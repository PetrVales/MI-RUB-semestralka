require "rspec"
require_relative "../lib/html_validator"
require_relative "../lib/html_rules"

describe "HTML validator" do

  before(:each) do
    @validator = HtmlValidator.new(HtmlRules.new)
  end

  it "should validate testFile.html" do
    @validator.validate(File.new("./resources/spec/testFile.html")).should eq true
  end

  it "should fail invalidTestFile.html" do
    @validator.validate(File.new("./resources/spec/invalidTestFile.html")).should eq false
  end

  it "should validate attrsTestFile.html" do
    @validator.validate(File.new("./resources/spec/attrsTestFile.html")).should eq true
  end

  it "should fail invalidAttrsTestFile.html" do
    @validator.validate(File.new("./resources/spec/invalidAttrsTestFile.html")).should eq false
  end

  it "should validate fit.html" do
    @validator.validate(File.new("./resources/spec/fit.html")).should eq true
  end
end