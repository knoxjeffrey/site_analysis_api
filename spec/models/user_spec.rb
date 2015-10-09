require 'rails_helper'

describe User do

  let(:user) { Fabricate.build(:user) }

  subject { user }

  it { should have_many :user_projects}
  it { should have_many(:projects).through(:user_projects) }

  it { should be_valid }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:full_name) }

  it { should validate_presence_of(:email) }
  it { should validate_confirmation_of(:password) }
  it { should validate_presence_of(:full_name) }

  it { should allow_value('foo@domain.com').for(:email) }

  describe "when email is not present" do
    before { user.email = "" }
    it { should_not be_valid }
  end


end