require "test_helper"


class InstanceTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:instance_users).dependent(:destroy)
    should have_many(:users).through(:instance_users)
  end

end
