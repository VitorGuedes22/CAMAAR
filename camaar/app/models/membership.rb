class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :course_class

  validates :role, presence: true, inclusion: { in: %w[docente discente] }
end
