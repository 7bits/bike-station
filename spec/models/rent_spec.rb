require 'rails_helper'

RSpec.describe Rent, :type => :model do
  context 'scopes' do
    subject { Rent }
    it { should respond_to :opened }
    it { should respond_to :closed }
    it { should respond_to :today }
    it { should respond_to :for_station }
  end

  let(:rent) { FactoryGirl.create :rent }
  subject { rent }

  it { should respond_to :opened_at }
  it { should respond_to :closed_at }
  
  it { should respond_to :bike }
  it { should respond_to :user }
  it { should respond_to :starting_station }
  it { should respond_to :terminal_station }

  it { should respond_to :duration }
  
  it { should be_valid }
end
