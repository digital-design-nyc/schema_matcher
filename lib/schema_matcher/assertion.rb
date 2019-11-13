require 'json-schema'
require 'schema_matcher/extended_schema'

module SchemaMatcher
  class Assertion
    attr_reader :errors

    def initialize(schema_name, payload, options = {})
      @schema_name = schema_name.to_sym
      @payload = payload
      @options = options
    end

    def valid?
      @errors = JSON::Validator.fully_validate(schema, payload, validator_options)
      return true if @errors.empty?

      false
    end

    private

    attr_reader :payload, :schema_name, :last_error_message, :options

    def schema
      entity_schema =
        if array?
          { 'type' => 'array', 'items' => SchemaMatcher.schema[schema_name] }
        else
          SchemaMatcher.schema[schema_name]
        end
      entity_schema
        .merge('$schema' => SchemaMatcher::ExtendedSchema::SCHEMA_URI)
        .merge!(definitions: SchemaMatcher.schema)
    end

    def array?
      options.key?(:array) ? options[:array] : payload.is_a?(Array)
    end

    def validator_options
      {
        strict: true
      }
    end
  end
end
