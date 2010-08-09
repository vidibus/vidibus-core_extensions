require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "vidibus-core_extensions"
    gem.summary = %Q{Extends the ruby core.}
    gem.description = %Q{Provides some extensions to the ruby core.}
    gem.email = "andre@vidibus.com"
    gem.homepage = "http://github.com/vidibus/vidibus-core_extensions"
    gem.authors = ["Andre Pankratz"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |t|
  t.spec_files = FileList['spec/vidibus/**/*_spec.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', '^spec,/gems/']
end

task :spec => :check_dependencies
task :default => :spec

require "rake/rdoctask"
Rake::RDocTask.new do |rdoc|
  version = File.exist?("VERSION") ? File.read("VERSION") : ""
  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "vidibus-uuid #{version}"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("lib/**/*.rb")
  rdoc.options << "--charset=utf-8"
end
