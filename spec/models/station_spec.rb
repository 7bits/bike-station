require 'rails_helper'

RSpec.describe Station, :type => :model do
  let(:station) { FactoryGirl.create :station }
  subject { station }

  it { should respond_to :name }
  it { should respond_to :latitude }
  it { should respond_to :longitude }

  it { should respond_to :bikes }
  it { should respond_to :outgoing_rents }
  it { should respond_to :incoming_rents }

  it { should be_valid }
end
