require "spec_helper"

describe "Vidibus::CoreExtensions::Object" do
  describe "#try!" do
    let(:dog) do
      Struct.new("Dog", :out) unless defined?(Struct::Dog)
      Struct::Dog.new(true)
    end

    it "should return defined method" do
      dog.try!(:out).should be_true
    end

    it "should return nil when calling undefined method" do
      dog.try!(:food).should be_nil
    end

    it "should re-raise exceptions" do
      stub(dog).bark { raise("wuff") }
      expect {dog.try!(:bark)}.to raise_exception("wuff")
    end
  end
end
