require "spec_helper"

describe "FileUtils" do
  describe ".remove_dir_r" do
    let(:tmpdir) { File.join(File.dirname(__FILE__), "..", "..", "tmp") }
    before { FileUtils.mkdir_p("#{tmpdir}/some/test/dir")}

    it "should remove the current directory and all its parents up to three levels deep" do
      FileUtils.remove_dir_r("#{tmpdir}/some/test/dir")
      File.exist?("#{tmpdir}/some").should be_false
      File.exist?(tmpdir).should be_true
    end

    it "should not remove parent directory unless it is emtpy" do
      FileUtils.touch("#{tmpdir}/some/textfile.txt")
      FileUtils.remove_dir_r("#{tmpdir}/some/test/dir")
      File.exist?("#{tmpdir}/some").should be_true
    end

    it "should remove all child directories recursively" do
      FileUtils.mkdir_p("#{tmpdir}/some/test/dir/with/some/children")
      FileUtils.remove_dir_r("#{tmpdir}/some/test/dir")
      File.exist?("#{tmpdir}/some").should be_false
    end

    it "should remove parent directories up to provided depth only" do
      FileUtils.remove_dir_r("#{tmpdir}/some/test/dir", 2)
      File.exist?("#{tmpdir}/some").should be_true
    end

    after { FileUtils.remove_dir(tmpdir)}
  end
end
