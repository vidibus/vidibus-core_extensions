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
end