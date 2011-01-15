require "spec_helper"

describe "Array" do
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

    context "with :strict option" do
      it "should merge [] with [1,2]" do
        array = [1,2]
        [].merge(array, :strict => true).should eql([])
        array.should eql([1,2])
      end

      it "should merge [1,'a'] with [3,1,2]" do
        array = [3,1,2]
        [1,'a'].merge(array, :strict => true).should eql([3,1,2,'a'])
        array.should be_empty
      end
    end
  end

  describe "#merge_nested" do
    it "should merge [[]] with [[1,2]]" do
      [[]].merge_nested([[1,2]]).should eql([[1,2]])
    end

    it "should merge [[]] with [[1],[2]]" do
      [[]].merge_nested([[1],[2]]).should eql([[1,2]])
    end

    it "should merge [[],[]] with [[1],[2]]" do
      [[],[]].merge_nested([[1],[2]]).should eql([[1],[2]])
    end

    it "should merge [[1],[]] with [[1],[2]]" do
      [[1],[]].merge_nested([[1],[2]]).should eql([[1],[2]])
    end

    it "should merge [[1],[2]] with [[1],[2]]" do
      [[1],[2]].merge_nested([[1],[2]]).should eql([[1],[2]])
    end

    it "should merge [[2],[1]] with [[1],[2]]" do
      [[2],[1]].merge_nested([[1],[2]]).should eql([[2],[1]])
    end

    it "should merge [[2]] with [[1],[2]]" do
      [[2]].merge_nested([[1],[2]]).should eql([[2,1]])
    end

    it "should merge [[2],[]] with [[1],[2]]" do
      [[2],[]].merge_nested([[1],[2]]).should eql([[2,1],[]])
    end

    it "should merge [[1,2,3]] with [[1,2],[3]]" do
      [[1,2,3]].merge_nested([[1,2],[3]]).should eql([[1,2,3]])
    end

    it "should merge [[1,2],[3]] with [[1],[2,3]]" do
      [[1,2],[3]].merge_nested([[1],[2,3]]).should eql([[1,2],[3]])
    end

    it "should keep source intact" do
      source = [[1,2]]
      [[1,2]].merge_nested(source)
      source.should eql([[1,2]])
    end
  end

  describe "#flatten_with_boundaries" do
    it "should flatten [[1]]" do
      [[1]].flatten_with_boundaries.should eql(["__a0",1,"__a0"])
    end

    it "should flatten [[1],2,[3]]" do
      [[1],2,[3]].flatten_with_boundaries.should eql(["__a0",1,"__a0",2,"__a1",3,"__a1"])
    end

    it "should flatten [1,[2],3]" do
      [1,[2],3].flatten_with_boundaries.should eql([1,"__a0",2,"__a0",3])
    end

    it 'should flatten [1,[2],3,4,[["x"]]]' do
      [1,[2],3,4,[["x"]]].flatten_with_boundaries.should eql([1,"__a0",2,"__a0",3,4,"__a1",["x"],"__a1"])
    end

    it "should handle [1,2]" do
      [1,2].flatten_with_boundaries.should eql([1,2])
    end
  end

  describe "#convert_boundaries" do
    it 'should convert ["__a0",1,"__a0"]' do
      ["__a0",1,"__a0"].convert_boundaries.should eql([[1]])
    end

    it 'should convert ["__a0",1,"__a0",2,"__a1",3,"__a1"]' do
      ["__a0",1,"__a0",2,"__a1",3,"__a1"].convert_boundaries.should eql([[1],2,[3]])
    end

    it 'should convert [1,"__a0",2,"__a0",3]' do
      [1,"__a0",2,"__a0",3].convert_boundaries.should eql([1,[2],3])
    end

    it 'should convert [1,"__a0",2,"__a0",3,4,"__a1",["x"],"__a1"]' do
      [1,"__a0",2,"__a0",3,4,"__a1",["x"],"__a1"].convert_boundaries.should eql([1,[2],3,4,[["x"]]])
    end

    it "should convert [1,2]" do
      [1,2].convert_boundaries.should eql([1,2])
    end
  end

  describe "#sort_by_map" do
    it "should sort the list of hashes by given order of attribute values" do
      list = [{:n => "two"}, {:n => "one"}, {:n => "three"}]
      map = ["one", "two", "three"]
      list.sort_by_map(map, :n).should eql([{:n => "one"}, {:n => "two"}, {:n => "three"}])
    end

    it "should sort the list of objects by given order of attribute values" do
      list = []
      list << OpenStruct.new(:n => "two")
      list << OpenStruct.new(:n => "one")
      list << OpenStruct.new(:n => "three")
      map = ["one", "two", "three"]
      ordered = list.sort_by_map(map, :n)
      ordered[0].n.should eql("one")
      ordered[1].n.should eql("two")
      ordered[2].n.should eql("three")
    end

    it "should sort the list of values by given order" do
      list = ["two", "one", "three"]
      map = ["one", "two", "three"]
      list.sort_by_map(map).should eql(["one", "two", "three"])
    end
  end
end
