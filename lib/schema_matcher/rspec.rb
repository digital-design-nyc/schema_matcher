require 'schema_matcher/rspec_matchers'

RSpec.configure do |config|
  config.include(SchemaMatcher::RspecMatchers)
end
