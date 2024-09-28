class CoourseUser < ApplicationRecord

  belongs_to :user, inverse_of: :coourse_users
  belongs_to :coourse, inverse_of: :coourse_users
end
