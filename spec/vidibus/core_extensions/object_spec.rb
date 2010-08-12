require "spec_helper"

describe "Vidibus::CoreExtensions::Object" do
  describe "#try!" do
    let(:dog) do
      Struct.new("Dog", :out)
      Struct::Dog.new(true)
    end
    
    it "should return defined method" do
      dog.try!(:out).should be_true
    end

    it "should return nil when calling undefined method" do
      dog.try!(:food).should be_nil
    end
  end
end