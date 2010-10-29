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

  describe "#%" do
    it "should allow reqular printf behaviour" do
      string = "%s, %s" % ["Masao", "Mutoh"]
      string.should eql("Masao, Mutoh")
    end

    it "should accept named arguments" do
      string = "%{firstname}, %{familyname}" % {:firstname => "Masao", :familyname => "Mutoh"}
      string.should eql("Masao, Mutoh")
    end
  end

  describe "snip" do
    it "should truncate string to given length while preserving words" do
      "O Brother, Where Art Thou?".snip(13).should eql("O Brother, Where…")
    end

    it "should return whole string if it fits in given length" do
      "O Brother, Where Art Thou?".snip(100).should eql("O Brother, Where Art Thou?")
    end

    it "should return whole string if it equals length" do
      "O Brother, Where Art Thou?".snip(26).should eql("O Brother, Where Art Thou?")
    end

    it "should return whole string if it equals length" do
      "O Brother, Where Art Thou?".snip(11).should eql("O Brother,…")
    end

    it "should trim white space" do
      "O Brother,       Where Art Thou?".snip(11).should eql("O Brother,…")
    end
    
    it "should handle content with backets" do
      "O Brother (Or Sister), Where Art Thou?".snip(20).should eql("O Brother (Or Sister…")
    end
  end

  describe "strip_tags" do
    it "should remove all tags from string" do
      "<p>Think<br />different</p>".strip_tags.should eql("Thinkdifferent")
    end

    it "should even remove chars that aren't tags but look like ones" do
      "small < large > small".strip_tags.should eql("small  small")
    end
  end

  describe "strip_tags!" do
    it "should strip tags on self" do
      string = "<p>Think<br />different</p>"
      string.strip_tags!
      string.should eql("Thinkdifferent")
    end
  end
end
