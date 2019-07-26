require 'spec_helper'

RSpec.describe SchemaMatcher::Builder do
  let(:builder) do
    SchemaMatcher::Builder
  end

  describe 'schema' do
    it 'has schema' do
      expect(builder.schema).to be
    end

    it 'has user and post entities in schema' do
      expect(builder.schema[:user]).to a_kind_of(SchemaMatcher::Entity)
      expect(builder.schema[:post]).to a_kind_of(SchemaMatcher::Entity)
    end
  end

  describe '#to_schema' do
    it 'returns schema' do
      expect(builder.to_schema).to match(
        user: builder.schema[:user].to_schema,
        post: builder.schema[:post].to_schema
      )
    end
  end
end
