class Repository < ActiveRecord::Base
  validates :name, presence: true
  validates :url, presence: true

  belongs_to :project

  def github_format
    url[%r{github\.com/([\w]+/[\w_-]+)}, 1]
  end
end
