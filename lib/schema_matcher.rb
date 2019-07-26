require 'schema_matcher/version'
require 'schema_matcher/entity'
require 'schema_matcher/builder_api'
require 'schema_matcher/builder'

module SchemaMatcher
  @schema = nil

  def self.schema
    @schema ||= Builder.to_schema
  end

  def self.build_schema(&blk)
    Builder.class_eval(&blk)
  end
end
