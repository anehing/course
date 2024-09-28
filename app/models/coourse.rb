class Coourse < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  validates :creator, presence: true
  validates :updater, presence: true
  validates :instance, presence: true
  acts_as_tenant :instance, inverse_of: :coourse

  has_many :coourse_announcements, class_name: "Coourse::Announcement", dependent: :destroy
  has_many :coourse_users, inverse_of: :coourse, dependent: :destroy
  has_many :users, through: :coourse_users
end
