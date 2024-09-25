class Instance < ApplicationRecord
  # @!attribute [r] instance_users
  #   @note You are scoped by the current tenant, you might not see all.
  has_many :instance_users, dependent: :destroy

  # @!attribute [r] users
  #   @note You are scoped by the current tenant, you might not see all.
  has_many :users, through: :instance_users
  has_many :coourses, dependent: :destroy

  has_many :instance_announcements, class_name: "Instance::Announcement", dependent: :destroy
end
