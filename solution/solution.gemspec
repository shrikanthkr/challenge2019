lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "solution/version"

Gem::Specification.new do |spec|
  spec.name          = "solution"
  spec.version       = Solution::VERSION
  spec.authors       = ["shrikanthkr"]
  spec.email         = ["shrikanth_kr@yahoo.com"]

  spec.summary       = "A challenge for QUBE"
  spec.description   = "A challenge for QUBE"
  spec.homepage      = "https://github.com/shrikanthkr/challenge2019"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files`.split("/n").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  puts spec.files
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
