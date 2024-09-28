require "test_helper"
require "debug"
class InstanceTest < ActiveSupport::TestCase
  test "associations" do
    assert have_many(:instance_users).dependent(:destroy)
    assert have_many(:users).through(:instance_users)
    assert have_many(:coourses).dependent(:destroy)
    assert have_many(:announcements).class_name(Instance::Announcement.name).dependent(:destroy)
  end

  context "hostname validation" do
    context "when hostname format is invalid" do
      hosts = [ "example,com", "www_.example.org", "example_.org", "example.org_",
               "example .org", "example. org", "example.org.." ]

      should_not allow_value(*hosts).for(:host)
    end

    context "when hostname format is valid" do
      hosts = %w[example.ORG www.example.org ex-ample.org example.org.sg]
      should allow_value(*hosts).for(:host)
    end

    context "when hostname is too long" do
      should_not allow_value("#{'a' * 255}.com").for(:host)
    end
    context "when saving instance without modifying host, does not validate the host" do
        should Instance.default.save
    end
  end

  test "order_for_display: orders the default instance first, then alphabetically by name" do
    listing = Instance.order_for_display
    assert_equal listing.first, Instance.default
    # Drop the 'Default' instance.
    listing = listing.drop(1)
    # Check that the rest of the names are ordered alphabetically.
    names = listing.map(&:name)
    assert_not_empty names
    assert names.each_cons(2).all? { |a, b| a <= b }
  end

  describe "#containing_user" do
    let(:instances) {  Instance.all[-4..-1] }
    let(:instances_with_user) { instances[0..2] }
    let(:user) { User.first }
    before do
      instances_with_user.each do |instance|
        ActsAsTenant.with_tenant(instance) do
          InstanceUser.create(instance: instance, user: user)
        end
      end
    end
    it "returns the correct set of instances" do
      ActsAsTenant.without_tenant do
        instances_with_user.each do |instance|
          assert_includes Instance.containing_user(user), instance
        end
      end
    end
  end

  describe ".find_tenant_by_host" do
    it "finds the correct tenant if the host is correct" do
      Instance.all.each do |instance|
        assert_equal Instance.find_tenant_by_host(instance.host), instance
      end
    end
  end

  test ".find_tenant_by_host_or_default# finds the correct tenant if the host is correct" do
    instance = instances(:one)
    assert_equal instance, Instance.find_tenant_by_host_or_default(instance.host)
  end

  test ".find_tenant_by_host_or_default# defaults to the default host if the host is not found " do
    assert_equal Instance.find_tenant_by_host_or_default("some-website.com"), Instance.default
  end
  test "" do
    ActsAsTenant.with_tenant(:instance) do
    end
  end

end
