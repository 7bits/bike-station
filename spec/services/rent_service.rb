require 'rails_helper'

RSpec.describe RentService do
  let(:service) { RentService.new }
  let(:user) { FactoryGirl.create :user }
  let(:bike) { FactoryGirl.create :bike }
  it { should respond_to :open_rent }
  it { should respond_to :close_rent }

  describe 'when open rent' do
    it 'create rent in db' do
      expect(service.open_rent(user, bike)).to change { Rent.count }.by(1)
    end

    it 'closed at is nul' do
      expect(service.open_rent(user, bike).closed_at).to be_nil 
      expect(service.open_rent(user, bike).openned_at).to_not be_nil 
    end
  end

  describe 'when close rent' do
    before { service.open_rent(user, bike) }

    it 'set closed_at' do
      expect(service.close_rent(bike).closed_at).to_not be_nil 
    end
  end
end