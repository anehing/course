require "test_helper"

class InstanceTest < ActiveSupport::TestCase
  test "associations" do
    assert have_many(:instance_users).dependent(:destroy)
    assert have_many(:users).through(:instance_users)
    assert have_many(:coourses).dependent(:destroy)
    assert have_many(:announcements).class_name(Instance::Announcement.name).dependent(:destroy)
  end
end
