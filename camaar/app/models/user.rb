class User < ApplicationRecord
  has_many :memberships
  has_many :course_classes, through: :memberships

  has_secure_password(validations: false)

  validates :usuario, presence: true, uniqueness: true
  validates :password, presence: true, on: :update, allow_nil: true
end
