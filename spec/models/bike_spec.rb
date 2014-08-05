require 'rails_helper'

RSpec.describe Bike, :type => :model do
  let(:bike) { FactoryGirl.create :bike }
  subject { bike }

  it { should respond_to :rents }
  it { should respond_to :station }
  it { should respond_to :uuid }
  it { should respond_to :registration_id }

  it { should be_valid }
end
