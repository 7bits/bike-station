require 'rails_helper'

RSpec.describe Rent, :type => :model do
  let(:rent) { FactoryGirl.create :rent }
  subject { rent }

  it { should respond_to :openned_at }
  it { should respond_to :closed_at }
  
  it { should respond_to :bike }
  it { should respond_to :user }

  it { should be_valid }
end
