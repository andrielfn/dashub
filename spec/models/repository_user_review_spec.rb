require 'spec_helper'

describe RepositoryUserReview do
  describe '#fully_reviewed?' do
    it 'returns true if no pull request to review' do
      repository = double(open_pull_request: [])
      user = double(username: 'john')

      expect(RepositoryUserReview.new(repository, user)).to be_fully_reviewed
    end

    it 'returns false if there are pull requests to be reviewed' do
      pull_request = double(users_approval: [])
      repository = double(open_pull_request: [pull_request])
      user = double(username: 'john')

      expect(RepositoryUserReview.new(repository, user)).not_to be_fully_reviewed
    end
  end

  describe '#pull_requests_missing_review' do
    it 'returns pull requests where the user did not approved' do
      pull_request = double(users_approval: ['john'])
      missing_pull_request = double(users_approval: [])
      repository = double(open_pull_request: [pull_request, missing_pull_request])
      user = double(username: 'john')

      review = RepositoryUserReview.new(repository, user)
      missing_review = review.pull_requests_missing_review

      expect(missing_review).to eq [missing_pull_request]
    end
  end

  describe '#pull_requests_reviewed' do
    it 'returns pull requests where the user approved' do
      pull_request = double(users_approval: ['john'])
      missing_pull_request = double(users_approval: [])
      repository = double(open_pull_request: [pull_request, missing_pull_request])
      user = double(username: 'john')

      review = RepositoryUserReview.new(repository, user)
      reviewed = review.pull_requests_reviewed

      expect(reviewed).to eq [pull_request]
    end
  end
end
