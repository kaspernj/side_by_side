Gem::Specification.new do |spec|
  spec.name = "side_by_side"
  spec.version = "0.0.1"
  spec.authors = ["kaspernj"]
  spec.email = ["k@spernj.org"]

  spec.summary = "Run and control processes."
  spec.description = "Run and control processes."
  spec.homepage = "https://github.com/kaspernj/side_by_side"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kaspernj/side_by_side"
  spec.metadata["changelog_uri"] = "https://github.com/kaspernj/side_by_side/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"

  spec.metadata["rubygems_mfa_required"] = "true"
end
