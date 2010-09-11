require "spec_helper"

describe "Vidibus::CoreExtensions::Hash" do
  describe "#to_uri" do
    it "should join params with '&'" do
      hash = { :some => "value", :another => "thing" }
      parts = hash.to_uri.split("&")
      parts.sort.should eql(['another=thing', 'some=value'])
    end
    
    it "should return items as urlencoded string" do
      hash = { :another => "speciál" }
      hash.to_uri.should eql("another=speci%C3%A1l")
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
    
    it "should work with array as parameter" do
      hash = { :name => "rodrigo", :age => 21 }
      hash.only([:name, :something]).should eql({ :name => "rodrigo" })
    end
    
    it "should work for nested hash" do
      hash = { :name => "rodrigo", :girlfriends => ["Anna", "Maria"] }
      hash.only(:name, :girlfriends).should eql({ :name => "rodrigo", :girlfriends => ["Anna", "Maria"] })
    end
  end
  
  describe "#except" do
    it "should return a copy of self but including only the given keys" do
      hash = { :name => "rodrigo", :age => 21 }
      hash.except(:name).should eql({ :age => 21 })
    end
    
    it "should work with array as parameter" do
      hash = { :name => "rodrigo", :age => 21 }
      hash.except([:name, :something]).should eql({ :age => 21 })
    end
    
    it "should work for nested hash" do
      hash = { :name => "rodrigo", :girlfriends => ["Anna", "Maria"] }
      hash.except(:name).should eql({ :girlfriends => ["Anna", "Maria"] })
    end
  end
  
  describe "#to_a_rec" do
    it "should return an array" do
      hash = {:some => "thing"}
      hash.to_a_rec.should eql([[:some, "thing"]])
    end
    
    it "should return an array of from nested attributes" do
      hash = {:some => {:nested => {:complicated => "thing", :is => ["really", "groovy"]}}, :with => "style"}
      hash.to_a_rec.should eql([[:with, "style"], [:some, [[:nested, [[:complicated, "thing"], [:is, ["really", "groovy"]]]]]]])
    end
  end
  
  describe ".build" do
    it "should return a hash" do
      Hash.build.should eql(Hash.new)
    end
    
    it "should accept a hash" do
      Hash.build({ :do => :it }).should eql({ :do => :it })
    end
    
    it "should accept an array" do
      Hash.build([:do, :it]).should eql({ :do => :it })
    end
    
    it "should accept an array and flatten it once" do
      Hash.build([:do, [:it]]).should eql({ :do => :it })
    end
    
    it "should not accept a multi-level array" do
      expect { Hash.build([:do, [:it, [:now]]]) }.to raise_error(ArgumentError, "odd number of arguments for Hash")
    end
  end
end
