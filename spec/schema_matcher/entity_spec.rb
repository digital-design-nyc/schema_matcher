require 'spec_helper'

RSpec.describe SchemaMatcher::Entity do
  describe 'to swagger' do
    let :swagger_schema do
      entity.to_schema
    end

    context 'Attribute without options' do
      let(:entity) do
        described_class.new do
          attribute :title
        end
      end

      it 'returns schema with string type' do
        expect(swagger_schema).to match(
          type: :object,
          properties: {
            title: { type: :string, required: true }
          }
        )
      end
    end

    context 'Attribute with defined type' do
      let(:entity) do
        described_class.new do
          attribute :id, type: :number
        end
      end

      it 'returns schema with number type' do
        expect(swagger_schema).to match(
          type: :object,
          properties: {
            id: { type: :number, required: true }
          }
        )
      end
    end

    context 'Attribute with nullable' do
      let(:entity) do
        described_class.new do
          attribute :id, type: :number, nullable: true
        end
      end

      it 'returns schema with number type' do
        expect(swagger_schema).to match(
          type: :object,
          properties: {
            id: { type: :number, 'x-nullable' => true, required: true }
          }
        )
      end
    end

    context 'Optional attribute' do
      let(:entity) do
        described_class.new do
          attribute :id, type: :number
          attribute :token, optional: true
        end
      end

      it 'returns schema with correct required field' do
        expect(swagger_schema).to match(
          type: :object,
          properties: {
            id: { type: :number, required: true },
            token: { type: :string, required: false }
          }
        )
      end
    end

    context 'Attribute with array and referral' do
      let(:entity) do
        described_class.new do
          attribute :ids, array: true, type: :integer
        end
      end

      it 'returns schema with number type' do
        expect(swagger_schema).to match(
          type: :object,
          properties: {
            ids: {
              type: :array,
              item: { type: :integer },
              required: true
            }
          }
        )
      end
    end

    context 'Attribute with array and referral' do
      let(:entity) do
        described_class.new do
          attribute :posts, array: true, ref: :post
        end
      end

      it 'returns schema with number type' do
        expect(swagger_schema).to match(
          type: :object,
          properties: {
            posts: {
              type: :array,
              item: { '$ref' => '#/definitions/post' },
              required: true
            }
          }
        )
      end
    end

    context 'Many attributes' do
      let(:entity) do
        described_class.new do
          attribute :id, type: :number
          attribute :title
          attribute :text, nullable: true
          attribute :comments, array: true, ref: :comment
          attribute :author, ref: :user
        end
      end

      it 'converts to swagger definitions correctly' do
        expect(swagger_schema).to match(
          type: :object,
          properties: {
            id: { type: :number, required: true },
            title: { type: :string, required: true },
            text: { type: :string, required: true, 'x-nullable' => true },
            comments: {
              type: :array,
              item: { '$ref' => '#/definitions/comment' },
              required: true
            },
            author: {
              '$ref' => '#/definitions/user'
            }
          }
        )
      end
    end

    context 'Nested entity' do
      let(:entity) do
        described_class.new do
          attribute :id, type: :number
          attribute :post do
            attribute :id, type: :number
            attribute :title, type: :string
          end
        end
      end

      it 'returns nested object in schema' do
        expect(swagger_schema).to match(
          type: :object,
          properties: {
            id: { type: :number, required: true },
            post: {
              type: :object,
              properties: {
                id: { type: :number, required: true },
                title: { type: :string, required: true }
              },
              required: true
            }
          }
        )
      end
    end
  end
end
