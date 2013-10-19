class Project < ActiveRecord::Base
  validates :name, presence: true
  validates :approval_emoji, presence: true
  validates :required_approvals, numericality: { only_integer: true, greater_than: 0 }

  has_many :repositories
end
