# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "representation"
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Johnson", "Chris Baker"]
  s.date = "2012-06-19"
  s.description = "Create different, named representations of a resource for cleaner state representation."
  s.email = "chris@socialvibe.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".rvmrc",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/representation.rb",
    "representation.gemspec",
    "spec/representation_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/connection.rb",
    "spec/support/models.rb",
    "spec/support/schema.rb",
    "watchr.rb"
  ]
  s.homepage = "http://github.com/socialvibe/representation"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Model logical groups of attributes as different object representations."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, [">= 3.1.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.1.0"])
      s.add_development_dependency(%q<activerecord>, [">= 3.1.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<jeweler>, [">= 1.6.4"])
      s.add_development_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_development_dependency(%q<watchr>, [">= 0"])
    else
      s.add_dependency(%q<activemodel>, [">= 3.1.0"])
      s.add_dependency(%q<activesupport>, [">= 3.1.0"])
      s.add_dependency(%q<activerecord>, [">= 3.1.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<jeweler>, [">= 1.6.4"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_dependency(%q<watchr>, [">= 0"])
    end
  else
    s.add_dependency(%q<activemodel>, [">= 3.1.0"])
    s.add_dependency(%q<activesupport>, [">= 3.1.0"])
    s.add_dependency(%q<activerecord>, [">= 3.1.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<jeweler>, [">= 1.6.4"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
    s.add_dependency(%q<ruby-debug19>, [">= 0"])
    s.add_dependency(%q<watchr>, [">= 0"])
  end
end

