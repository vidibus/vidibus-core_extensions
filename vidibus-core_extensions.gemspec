# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vidibus-core_extensions}
  s.version = "0.3.17"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andre Pankratz"]
  s.date = %q{2011-02-25}
  s.description = %q{Provides some extensions to the ruby core.}
  s.email = %q{andre@vidibus.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".bundle/config",
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/vidibus-core_extensions.rb",
    "lib/vidibus/core_extensions.rb",
    "lib/vidibus/core_extensions/array.rb",
    "lib/vidibus/core_extensions/file_utils.rb",
    "lib/vidibus/core_extensions/hash.rb",
    "lib/vidibus/core_extensions/object.rb",
    "lib/vidibus/core_extensions/string.rb",
    "spec/spec_helper.rb",
    "spec/vidibus/core_extensions/array_spec.rb",
    "spec/vidibus/core_extensions/file_utils_spec.rb",
    "spec/vidibus/core_extensions/hash_spec.rb",
    "spec/vidibus/core_extensions/object_spec.rb",
    "spec/vidibus/core_extensions/string_spec.rb",
    "vidibus-core_extensions.gemspec"
  ]
  s.homepage = %q{http://github.com/vidibus/vidibus-core_extensions}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{vidibus-core_extensions}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Extends the ruby core.}
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/vidibus/core_extensions/array_spec.rb",
    "spec/vidibus/core_extensions/file_utils_spec.rb",
    "spec/vidibus/core_extensions/hash_spec.rb",
    "spec/vidibus/core_extensions/object_spec.rb",
    "spec/vidibus/core_extensions/string_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rr>, [">= 0"])
      s.add_development_dependency(%q<relevance-rcov>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rr>, [">= 0"])
      s.add_dependency(%q<relevance-rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rr>, [">= 0"])
    s.add_dependency(%q<relevance-rcov>, [">= 0"])
  end
end

