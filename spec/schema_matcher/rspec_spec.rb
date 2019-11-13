require 'spec_helper'
require 'schema_matcher/rspec'

RSpec.describe 'RspecMatchers' do
  let(:user_attributes) { attributes_for(:user).stringify_keys! }
  let(:payload) { user_attributes }

  it 'pass validation' do
    expect(payload).to match_json_schema(:user)
  end

  context 'when payload is empty' do
    let(:payload) { {} }
    it 'does not pass validation' do
      expect(payload).to_not match_json_schema(:user)
    end
  end

  context 'when payload is array' do
    let(:payload) do
      [attributes_for(:user), attributes_for(:user)].map(&:stringify_keys)
    end

    it 'pass validation' do
      expect(payload).to match_json_schema(:user, array: true)
    end
  end

  context 'when payload has extra fields' do
    let(:payload) { user_attributes.merge('some_other_field' => true) }

    it 'does not pass validation' do
      expect do
        expect(payload).to match_json_schema(:user)
      end.to raise_error(/contained undefined properties/)
      expect(payload).to_not match_json_schema(:user)
    end
  end

  context 'when payload has type mismatch' do
    let(:payload) { user_attributes.merge('id' => '123') }

    it 'does not pass validation' do
      expect do
        expect(payload).to match_json_schema(:user)
      end.to raise_error(/type string did not match/)
      expect(payload).to_not match_json_schema(:user)
    end
  end

  describe 'when array is empty' do
    let(:payload) { user_attributes.merge('post_ids' => []) }
    it 'pass validation' do
      expect(payload).to match_json_schema(:user)
    end
  end

  describe 'with referrals' do
    let(:payload) { [attributes_for(:post)] }

    it 'pass validation' do
      expect(payload).to match_json_schema(:post, array: true)
    end

    context 'referal attribute is blank' do
      let(:payload) { [attributes_for(:post, 'author' => nil)] }

      it 'pass validation' do
        expect(payload).to match_json_schema(:post_with_nullable_author, array: true)
      end
    end
  end

  describe 'with nested' do
    context 'when nil' do
      let(:payload) { [attributes_for(:post, 'author' => nil)] }

      it 'passes validation' do
        expect(payload).to match_json_schema(:post_with_optional_author, array: true)
      end
    end

    context 'when present' do
      let(:payload) { attributes_for(:post) }

      it 'passes validation' do
        expect(payload).to match_json_schema(:post_with_optional_author)
      end
    end
  end
end
