module SchemaMatcher
  module BuilderApi
    def self.included(base)
      base.instance_variable_set(:@schema, {})
      base.extend ClassMethods
    end

    module ClassMethods
      def schema
        instance_variable_get(:@schema)
      end

      def define(model, &blk)
        schema[model] = Entity.new(&blk)
      end

      def to_schema
        schema.transform_values(&:to_schema)
      end
    end
  end
end
