require 'rails_helper'

RSpec.describe Endpoint, type: :model do
  describe 'validations' do
    subject { FactoryBot.build(:endpoint) }

    it { should validate_presence_of(:verb) }
    it { should validate_presence_of(:path) }

    it 'validates uniqueness of path scoped by verb' do
      FactoryBot.create(:endpoint, verb: 'GET', path: '/test')
      should validate_uniqueness_of(:path).scoped_to(:verb).case_insensitive
    end

    it 'validates the format of path' do
      should allow_value('/valid_path').for(:path)
      should_not allow_value('invalid/path').for(:path)
      should_not allow_value('/invalid_path//').for(:path)
      should_not allow_value('/invalid_path with spaces').for(:path)
    end

    it 'validates the model if it has the correct verb' do
      endpoint = Endpoint.new(verb: 'SOMETHING', path: '/test')
      endpoint.valid?

      expect(endpoint.errors.first.message).to eq('SOMETHING is not a valid verb')
    end
  end

  describe '#controller_action' do
    subject { endpoint.controller_action }

    context 'when verb is POST' do
      let(:endpoint) { FactoryBot.build(:endpoint, verb: 'POST') }
      it { is_expected.to eq(:post) }
    end

    context 'when verb is PATCH' do
      let(:endpoint) { FactoryBot.build(:endpoint, verb: 'PATCH') }
      it { is_expected.to eq(:patch) }
    end

    context 'when verb is UPDATE' do
      let(:endpoint) { FactoryBot.build(:endpoint, verb: 'UPDATE') }
      it { is_expected.to eq(:update) }
    end

    context 'when verb is DELETE' do
      let(:endpoint) { FactoryBot.build(:endpoint, verb: 'DELETE') }
      it { is_expected.to eq(:delete) }
    end

    context 'when verb is GET' do
      let(:endpoint) { FactoryBot.build(:endpoint, verb: 'GET') }
      it { is_expected.to eq(:get) }
    end
  end

  describe '#convert_verb' do
    subject { endpoint.converted_verb }

    context 'when the verb is UPDATE' do
      let(:endpoint) { FactoryBot.create(:endpoint, verb: 'UPDATE') }

      it { is_expected.to eq(:put) }
    end

    context 'when the verb is GET' do
      let(:endpoint) { FactoryBot.create(:endpoint, verb: 'GET') }

      it { is_expected.to eq(:get) }
    end
  end
end
