class ProjectUserReview
  attr_reader :project, :user

  def initialize(project, user)
    @project = project
    @user = user
  end

  # Public: returns ranked repositories for user.
  def ranked_repositories
    repositories_to_review.sort_by(&:fully_reviewed?)
  end

  private

  # Internal: returns user repositories review.
  def repositories
    @repositories ||= @project.repositories.map do |repo|
      UserRepositoryReview.new(repo, @user)
    end
  end
end
