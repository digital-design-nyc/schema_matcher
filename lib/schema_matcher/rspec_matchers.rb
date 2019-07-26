require 'schema_matcher'
require 'schema_matcher/assertion'

module SchemaMatcher
  module RspecMatchers
    class JsonSchemaMatcher
      attr_reader :schema_name, :payload, :assertion

      def initialize(schema_name)
        @schema_name = schema_name
      end

      def matches?(payload, options = {})
        @payload = payload
        @assertion = SchemaMatcher::Assertion.new(schema_name, payload, options)
        @assertion.valid?
      end

      def error_message
        @assertion.errors[0]
      end

      def failure_message
        <<~FAIL
          #{error_message}

          ---

          expected

          #{format_json(payload)}

          to match schema "#{schema_name}":

        FAIL
      end

      def failure_message_when_negated
        <<~FAIL
          #{error_message}

          ---

          expected

          #{format_json(payload)}

          not to match schema "#{schema_name}":

        FAIL
      end

      def failure_message_for_should
        failure_message
      end

      def failure_message_for_should_not
        failure_message_when_negated
      end

      def format_json(_json)
        JSON.pretty_generate(payload)
      end
    end

    def match_json_schema(schema)
      JsonSchemaMatcher.new(schema)
    end
  end
end
