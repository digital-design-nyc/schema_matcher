require 'json-schema'

module SchemaMatcher
  class ExtendedSchema < JSON::Schema::Draft4
    SCHEMA_URI = 'http://tempuri.org/schema_matcher/extended_schema'.freeze

    def initialize
      super
      @attributes['type'] = ExtendedTypeAttribute
      @attributes['properties'] = JSON::Schema::PropertiesAttribute
      @uri = URI.parse(SCHEMA_URI)
      @names = ['draft4-custom', SCHEMA_URI]
    end
  end

  class ExtendedTypeAttribute < JSON::Schema::TypeV4Attribute
    # rubocop:disable Metrics/ParameterLists
    def self.validate(current_schema, data, fragments, processor, validator, options = {})
      return if data.nil? && current_schema.schema['x-nullable']

      super
    end
    # rubocop:enable Metrics/ParameterLists
  end

  JSON::Validator.register_validator(ExtendedSchema.new)
end
