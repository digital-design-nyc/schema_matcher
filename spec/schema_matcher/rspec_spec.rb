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
    let(:post_attributes) { attributes_for(:post) }
    let(:payload) { post_attributes }

    it 'pass validation' do
      expect(payload).to match_json_schema(:post)
    end
  end
end
