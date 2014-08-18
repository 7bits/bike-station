require 'rails_helper'

RSpec.describe Admin, :type => :model do
  let(:admin) { FactoryGirl.create :admin }
  subject { admin }

  it { should respond_to :email }
  it { should be_valid }
end
