require "rspec"
require_relative "../lib/mark"

describe "Mark" do

  before(:each) do
    @mark = Mark.new("<div id=\"slice-method\" class=\"method-detail\">")
  end

  it "should return is mark" do
    @mark.isMark.should eq true
  end

  it "should recognized div" do
    @mark.isTag(:div).should eq true
    @mark.isTag(:DIV).should eq false
    @mark.isTag(:html).should eq false
  end

  it "should recognized html" do
    Mark.new("<html>").isTag(:html).should eq true
  end

  it "should recognized br//" do
    Mark.new("<br/>").isTag(:br).should eq true
  end

  it "should validate" do
    @mark.isValid.should eq true
  end

  it "should get its attributes" do
    @mark.getAttributes.should eq [:id, :class]
  end

  it "should get its attribute value" do
    @mark.getAttributeValue(:id).should eq "slice-method"
    @mark.getAttributeValue(:class).should eq "method-detail"
  end

  it "should test if contains attribute" do
    @mark.hasAttribute(:class).should eq true
    @mark.hasAttribute(:bla).should eq false
  end

  it "should distinguish open tag" do
    @mark.isOpen.should eq true
    Mark.new("<br/>").isOpen.should eq true
    Mark.new("</div>").isOpen.should eq false
  end

  it "should distinguish close tag" do
    @mark.isClose.should eq false
    Mark.new("<br/>").isClose.should eq true
    Mark.new("</div>").isClose.should eq true
  end

  it "should get mark name" do
    @mark.getName.should eq :div
    Mark.new("</div>").getName.should eq :div
  end

  it "should parse <link rel=\"alternate\" type=\"application/rss+xml\" title=\"Stranky FIT CVUT\" href=\"/rss-stranky.xml\" />" do
    mark = Mark.new("<link rel=\"alternate\" type=\"application/rss+xml\" title=\"Stranky FIT CVUT\" href=\"/rss-stranky.xml\" />")
    mark.getName.should eq :link
    mark.getAttributes.should eq [:rel, :type, :title, :href]
  end

  it "should parse <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />" do
    mark = Mark.new("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />")
    mark.getName.should eq :meta
    mark.getAttributes.should eq ["http-equiv".to_sym, :content]
  end

end