# frozen_string_literal: true

require_relative 'lib/edutils/version'

Gem::Specification.new do |spec|
  spec.name     = 'edutils'
  spec.version  = EDUtils::VERSION
  spec.authors  = ['Jeremy Iverson']
  spec.email    = ['jiverson002@csbsju.edu']

  spec.summary  = 'Basic utilities for managing an educational computing environment.'
  spec.homepage = 'https://github.com/jiverson002/edutils.git'
  spec.license  = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").select do |f|
    f.match(/^(bin|lib|spec|.yardopts|CHANGELOG|Gemfile|LICENSE|README)/i)
  end
  spec.executables = spec.files.grep(/^bin/).map { |f| File.basename(f) }

  spec.add_runtime_dependency 'safe_yaml', '~>1'

  spec.add_development_dependency 'bundler', '~>2'
end
