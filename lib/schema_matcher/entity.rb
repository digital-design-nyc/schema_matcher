module SchemaMatcher
  class Entity
    attr_reader :attributes

    def initialize(&blk)
      @attributes = {}
      instance_exec(&blk)
    end

    def attribute(name, options = {}, &blk)
      return attributes[name] = { type: self.class.new(&blk) }.merge(options).compact if block_given?

      attributes[name] = { type: :string }.merge(options).compact
    end

    def to_schema
      {
        type: :object,
        properties: attributes.transform_values { |attribute| swaggerize_attribute(attribute) }.compact
      }
    end

    private

    def swaggerize_attribute(attribute)
      if attribute[:array]
        {
          type: :array,
          item: attr_to_schema(attribute)
        }.merge(extra_schema_properties(attribute))
      else
        attr_to_schema(attribute).merge(extra_schema_properties(attribute))
      end
    end

    def attr_to_schema(attribute)
      return { '$ref' => "#/definitions/#{attribute[:ref]}" } if attribute[:ref]

      if attribute[:type].respond_to?(:to_schema)
        attribute[:type].to_schema
      else
        attribute.except(:nullable, :optional, :array)
      end
    end

    def extra_schema_properties(attribute)
      {
        'x-nullable' => attribute[:nullable],
        required: attribute[:ref] && !attribute[:array] ? nil : !attribute[:optional]
      }.compact
    end
  end
end
