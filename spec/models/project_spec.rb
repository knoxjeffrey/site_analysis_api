require 'rails_helper'

describe Project do

  it { should have_many :user_projects}
  it { should have_many(:users).through(:user_projects) }

  it { should belong_to :admin }

  it { should validate_presence_of :project_name }

  it { should validate_uniqueness_of :project_name }

  it { should validate_length_of(:project_name).is_at_least(3) }

end


