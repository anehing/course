require 'rails_helper'

RSpec.describe Instance, type: :model do
  it { is_expected.to have_many(:instance_users).dependent(:destroy) }
  it { is_expected.to have_many(:users).through(:instance_users) }
end
