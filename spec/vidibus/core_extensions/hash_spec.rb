require "spec_helper"

describe "Vidibus::CoreExtensions::Hash" do
  describe "#to_uri" do
    it "should return items as urlencoded string" do
      hash = { :some => :value, :another => "speciál" }
      hash.to_uri.should eql("some=value&another=speci%C3%A1l")
    end
    
    it "should support multi-level hashes" do
      hash = { :some => { :nested => :thing } }
      hash.to_uri.should eql("some=[nested=thing]")
    end
  end
  
  describe "#only" do
    it "should return a copy of self but including only the given keys" do
      hash = { :name => "rodrigo", :age => 21 }
      hash.only(:name).should eql({ :name => "rodrigo" })
    end
  end
  
  describe "#except" do
    it "should return a copy of self but including only the given keys" do
      hash = { :name => "rodrigo", :age => 21 }
      hash.except(:name).should eql({ :age => 21 })
    end
  end
end