class Project < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  validates :approval_emoji, presence: true
  validates :required_approvals, numericality: { only_integer: true, greater_than: 0 }

  has_many :repositories
  belongs_to :user
end
