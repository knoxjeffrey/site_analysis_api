require 'rails_helper'

describe User do

  let(:user) { Fabricate.build(:user) }

    subject { user }

    it { should be_valid }
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:full_name) }

    it { should validate_presence_of(:email) }
    it { should validate_confirmation_of(:password) }
    it { should allow_value('foo@domain.com').for(:email) }
    it { should validate_presence_of(:full_name) }

  end