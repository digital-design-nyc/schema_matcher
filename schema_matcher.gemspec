$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'schema_matcher/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'schema_matcher'
  spec.version     = SchemaMatcher::VERSION
  spec.authors     = ['Ivan Rudskikh']
  spec.email       = ['shredder.rull@gmail.com']
  spec.homepage    = 'https://github.com/digital-design-nyc/schema_matcher'
  spec.summary     = 'Use power of ruby DSL to validate json!'
  spec.description = 'Use power of ruby DSL to validate json!'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency('json-schema')

  spec.add_development_dependency 'factory_bot', '>= 4.8'
  spec.add_development_dependency 'ffaker'
  spec.add_development_dependency 'rspec', '>= 2.0'
end
