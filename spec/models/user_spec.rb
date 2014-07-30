require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create :user }
  subject { user }

  it { should respond_to :name }
  it { should respond_to :surname }
  it { should respond_to :is_anonimous }

  it { should respond_to :rents }

  it { should be_valid }
end
