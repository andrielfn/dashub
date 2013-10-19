require 'spec_helper'

describe ProjectUserReview do
  describe '#ranked_repositories' do
    it 'returns repositories by not fully reviewed' do
      review = ProjectUserReview.new(double, double)

      reviewed_repository = double(fully_reviewed?: true)
      not_reviewed = double(fully_reviewed?: false)
      review.stub(repositories_review: [reviewed_repository, not_reviewed])

      expect(review.ranked_repositories).to eq [not_reviewed, reviewed_repository]
    end
  end
end
