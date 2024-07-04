class User < ApplicationRecord
  has_many :memberships
  has_many :course_classes, through: :memberships

  validates :usuario, presence: true, uniqueness: true
  #validates :password, allow_nil: true
end
