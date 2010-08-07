require "spec_helper"

describe "Vidibus::CoreExtensions::Array" do
  describe "#flatten_once" do
    it "should return array" do
      array = ['go', 'for', 'it']
      array.flatten_once.should eql(['go', 'for', 'it'])
    end
    
    it "should return a flattened array" do
      array = ['go', ['for', 'it']]
      array.flatten_once.should eql(['go', 'for', 'it'])
    end
    
    it "should flatten first level only" do
      array = ['go', ['for', ['it']]]
      array.flatten_once.should eql(['go', 'for', ['it']])
    end
    
    it "should accept array with mixed values" do
      array = ["go", [1,2], { :it => "dude" }]
      array.flatten_once.should eql(["go", 1, 2, { :it => "dude" }])
    end
  end

  describe "#merge" do
    it "should merge [] with [1,2]" do
      [].merge([1,2]).should eql([1,2])
    end
    
    it "should merge [a] with [1,2]" do
      ['a'].merge([1,2]).should eql(['a',1,2])
    end
    
    it "should merge [1,'a'] with [1,2]" do
      [1,'a'].merge([1,2]).should eql([1,2,'a'])
    end
    
    it "should merge [1,'a'] with [3,1,2]" do
      [1,'a'].merge([3,1,2]).should eql([3,1,2,'a'])
    end
    
    it "should merge ['b',1,'a'] with [3,1,2]" do
      ['b',1,'a'].merge([3,1,2]).should eql(['b',3,1,2,'a'])
    end
    
    it "should merge [2,'b',1,'a'] with [3,1,2]" do
      [2,'b',1,'a'].merge([3,1,2]).should eql([2,'b',3,1,'a'])
    end
    
    it "should merge [2,'b',1,'a'] with [3,1,2,4]" do
      [2,'b',1,'a'].merge([3,1,2,4]).should eql([2,4,'b',3,1,'a'])
    end
    
    it "should merge [2,'b',1,'a'] with [5,3,6,7,1,2,4]" do
      [2,'b',1,'a'].merge([5,3,6,7,1,2,4]).should eql([2,4,'b',5,3,6,7,1,'a'])
    end
  end
end