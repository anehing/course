class Coourse < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  validates :creator, presence: true
  belongs_to :instance

  has_many :coourse_announcements, class_name: "Coourse::Announcement", dependent: :destroy
end
