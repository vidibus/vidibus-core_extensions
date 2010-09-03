# encoding: utf-8
require "spec_helper"

describe "Vidibus::CoreExtensions::String" do
  describe "::LATIN_MAP" do
    it "should contain a Hash map" do
      String::LATIN_MAP.should be_a(Hash)
    end
  end
  
  describe "#latinize" do
    it "should convert diacritics" do
      "ÀÁÂÃÄÅ Ç Ð ÈÉÊË ÌÍÎÏ Ñ ÒÓÔÕÖØ ÙÚÛÜ Ý àáâãäå ç èéêë ìíîï ñ òóôõöø ùúûü ý".latinize.should 
        eql("AAAAAEA C D EEEE IIII N OOOOOEO UUUUE Y aaaaaea c eeee iiii n oooooeo uuuue y")
    end
    
    it "should convert ligatures" do
      "Æ".latinize.should eql("AE")
      "ÆǼ æǽ Œ œ".latinize.should eql("AEAE aeae OE oe")
    end
    
    it "should keep some regular chars" do
      ".,|?!:;\"'=+-_".latinize.should eql(".,|?!:;\"'=+-_")
    end
    
    it "should replace exotic chars by whitespace" do
      "~÷≥≤˛`ˀð".latinize.should eql(" ")
    end
    
    it "should normalize white space" do
      "Hola señor, ¿cómo está?".latinize.should eql("Hola senor, como esta?")
    end
  end
  
  describe "#permalink" do
    it "should call #latinize" do
      string = "hey"
      mock(string).latinize { string }
      string.permalink.should eql(string)
    end
    
    it "should return lower chars only" do
      "HeLlo".permalink.should eql("hello")
    end
    
    it "should turn whitespace into dashes" do
      "hey joe".permalink.should eql("hey-joe")
    end
    
    it "should turn special chars into dashes" do
      "hi~there".permalink.should eql("hi-there")
    end
    
    it "should not begin with dashes" do
      ">duh".permalink.should eql("duh")
    end
    
    it "should not end with dashes" do
      "hi!".permalink.should eql("hi")
    end
    
    it "should convert multiple adjacent special chars into a single dash" do
      "Hola señor, ¿cómo está?".permalink.should eql("hola-senor-como-esta")
    end
  end
end
