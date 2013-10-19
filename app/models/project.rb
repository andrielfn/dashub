class Project < ActiveRecord::Base
  validates :name, presence: true
  validates :approval_emoji, presence: true
  validates :emoji_count, numericality: { only_integer: true, greater_than: 0 }

  has_many :repositories
end
