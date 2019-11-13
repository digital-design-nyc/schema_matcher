require 'json-schema'

module SchemaMatcher
  class ExtendedSchema < JSON::Schema::Draft3
    SCHEMA_URI = 'http://tempuri.org/schema_matcher/extended_schema'.freeze

    def initialize
      super
      @attributes['type'] = ExtendedTypeAttribute
      @attributes['$ref'] = ExtendedRefAttribute
      @uri = URI.parse(SCHEMA_URI)
      @names = ['draft3-custom', SCHEMA_URI]
    end
  end

  module NullablePossibility
    # rubocop:disable Metrics/ParameterLists
    def validate(current_schema, data, fragments, processor, validator, options = {})
      return if data.nil? && current_schema.schema['x-nullable']

      super
    end
    # rubocop:enable Metrics/ParameterLists
  end

  class ExtendedTypeAttribute < JSON::Schema::TypeAttribute
    extend NullablePossibility
  end

  class ExtendedRefAttribute < JSON::Schema::RefAttribute
    extend NullablePossibility
  end

  JSON::Validator.register_validator(ExtendedSchema.new)
end
