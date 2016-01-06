# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "shell_whisperer/version"

Gem::Specification.new do |spec|
  spec.name = "shell_whisperer"
  spec.version = ShellWhisperer::VERSION
  spec.authors = ["Max Jacobson"]
  spec.email = ["max@hardscrabble.net"]

  spec.summary = "A thin wrapper around ruby backticks to raise better errors."
  spec.homepage = "https://github.com/maxjacobson/shell_whisperer"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject { |f|
    f.match(%r{^(spec)/})
  }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
