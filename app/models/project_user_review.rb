class ProjectUserReview
  attr_reader :project, :user

  def initialize(project, user)
    @project = project
    @user = user
  end

  # Public: returns ranked repositories for user.
  def ranked_repositories
    repositories_review.sort_by do |repository|
      repository.fully_reviewed? ? 1 : -1
    end
  end

  # Public: returns user repositories review.
  def repositories_review
    @repositories ||= @project.repositories.map do |repo|
      next unless RepositoryAvailability.new(repo).available_for?(user)

      RepositoryUserReview.new(repo.full_name, @user, @project)
    end.compact
  end
end
