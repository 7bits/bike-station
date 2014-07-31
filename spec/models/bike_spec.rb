require 'rails_helper'

RSpec.describe Bike, :type => :model do
  let(:bike) { FactoryGirl.create :bike }
  subject { bike }

  it { should respond_to :rents }
  it { should respond_to :station }

  it { should be_valid }
end
