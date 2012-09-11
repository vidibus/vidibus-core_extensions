# encoding: utf-8
require "spec_helper"

describe "String" do
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

  describe "#snip" do
    it "should truncate string to given length while preserving words" do
      "O Brother, Where Art Thou?".snip(13).should eql("O Brother, Where…")
    end

    it "should return whole string if it fits in given length" do
      "O Brother, Where Art Thou?".snip(100).should eql("O Brother, Where Art Thou?")
    end

    it "should return whole string if it equals length" do
      "O Brother, Where Art Thou?".snip(26).should eql("O Brother, Where Art Thou?")
    end

    it "should strip white space between words" do
      "O Brother,       Where Art Thou?".snip(11).should eql("O Brother,…")
    end

    it "should strip trailing white space" do
      "O Brother, Where Art Thou? ".snip(26).should eql("O Brother, Where Art Thou?")
    end

    it "should strip leading white space" do
      " O Brother, Where Art Thou?".snip(26).should eql("O Brother, Where Art Thou?")
    end

    it "should handle content with backets" do
      "O Brother (Or Sister), Where Art Thou?".snip(20).should eql("O Brother (Or Sister…")
    end
  end

  describe "#strip_tags" do
    it "should remove all tags from string" do
      "<p>Think<br />different</p>".strip_tags.should eql("Thinkdifferent")
    end

    it "should even remove chars that aren't tags but look like ones" do
      "small < large > small".strip_tags.should eql("small  small")
    end
  end

  describe "#strip_tags!" do
    it "should strip tags on self" do
      string = "<p>Think<br />different</p>"
      string.strip_tags!
      string.should eql("Thinkdifferent")
    end
  end

  describe "#with_params" do
    it "should return the current string unless params are given" do
      "http://vidibus.org".with_params.should eql("http://vidibus.org")
    end

    it "should return the current string if an empty hash is given" do
      "http://vidibus.org".with_params({}).should eql("http://vidibus.org")
    end

    it "should return the current string with params as query" do
      "http://vidibus.org".with_params(:awesome => "yes").should eql("http://vidibus.org?awesome=yes")
    end

    it "should append params to existing query" do
      "http://vidibus.org?opensource=true".with_params(:awesome => "yes").should eql("http://vidibus.org?opensource=true&awesome=yes")
    end
  end

  describe '#sortable' do
    it 'should not convert a string that contains just downcase letters' do
      'hello'.sortable.should eq('hello')
    end

    it 'should convert a string that contains upcase letters' do
      'Hello'.sortable.should eq('hello')
    end

    it 'should strip whitespace' do
      'hel lo'.sortable.should eq('hello')
    end

    it 'should strip tabs' do
      'hel lo'.sortable.should eq('hello')
    end

    it 'should convert a string containing just a number' do
      '123'.sortable.should eq('00000000000000000000123.000000')
    end

    it 'should convert a string containing one float' do
      '1.23'.sortable.should eq('00000000000000000000001.230000')
    end

    it 'should convert a string containing one float with comma' do
      pending 'Use Rails\' number formatting for that?'
      '1,23'.sortable.should eq('00000000000000000000001.230000')
    end

    it 'should convert a string containing one number with comma as thousands separator' do
      pending 'Use Rails\' number formatting for that?'
      '1,234'.sortable.should eq('00000000000000000001234.000000')
    end

    it 'should convert a string containing one number with dot as thousands separator' do
      pending 'Use Rails\' number formatting for that?'
      '1.234'.sortable.should eq('00000000000000000001234.000000')
    end

    it 'should convert a string containing one number followed by a dot' do
      '1.'.sortable.should eq('00000000000000000000001.000000.')
    end

    it 'should convert a string containing one number at the beginning' do
      '123a'.sortable.should eq('00000000000000000000123.000000a')
    end

    it 'should convert a string containing one number in the middle' do
      'A 123 b'.sortable.should eq('a00000000000000000000123.000000b')
    end

    it 'should convert a string containing one number at the end' do
      'A 123 b'.sortable.should eq('a00000000000000000000123.000000b')
    end

    it 'should convert a string containing several numbers in the middle' do
      'A 123 b 4'.sortable.should eq('a00000000000000000000123.000000b00000000000000000000004.000000')
    end
  end
end
