require "rspec"
require_relative "../lib/doctype"

describe "Doctype" do

  it "should valid correct doctype html 5" do
    Doctype.new("<!DOCTYPE html>").isDoctype.should eq true
  end

  it "should valid correct doctype html 4.01 strict" do
    Doctype.new("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">").isDoctype.should eq true
  end

  it "should be doctype" do
    Doctype.new("<!DOCTYPE html>").isDoctype.should eq true
  end

end
