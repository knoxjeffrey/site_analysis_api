require 'rails_helper'

describe UserProject do

  it { should belong_to :user }
  it { should belong_to :project }

end