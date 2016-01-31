require 'rails_helper'

RSpec.describe BetterDoctorService do
  let(:search_params) { { 'name' => 'Doctor' } }

  describe '.call' do
    it 'invokes #call with an argument'do
      expect_any_instance_of(described_class).to receive(:call).with(search_params)
      described_class.call(search_params)
    end
  end

  describe '#call' do 
    before { Rails.cache.clear }
    it 'must add the search parameter to the cache' do
      expect(Rails.cache.exist?(search_params)).to be_falsey
      described_class.call(search_params)
      expect(Rails.cache.exist?(search_params)).to be_truthy
    end
  end
end
