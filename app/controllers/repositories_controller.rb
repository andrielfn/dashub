class RepositoriesController < ApplicationController
  # TODO: uncomment this after RailsRumble (guest user)
  # before_filter :authenticate_user!

  def new
    @project = current_user_or_guest_user.projects.find(params[:project_id])
    @repository = Repository.new
    @repositories = @project.repositories
    @suggested_repos = SuggestedRepositories.new(current_user_or_guest_user, @project).repos
  end

  def create
    @project = current_user_or_guest_user.projects.find(params[:project_id])
    @repository = @project.repositories.new(repository_params)

    access_availability = RepositoryAvailability.new(@repository)

    if access_availability.available_for?(current_user_or_guest_user)
      # TODO: remove this after RailsRumble (guest user)
      if !user_signed_in? || @repository.save
        redirect_to new_project_repository_path(@project), notice: 'Repository created successfully.'
        return
      end
    else
      flash.now[:alert] = "Couldn't find this repository :("
    end

    @suggested_repos = SuggestedRepositories.new(current_user_or_guest_user, @project).repos
    @repositories = @project.repositories(true)
    render action: :new
  end

  def destroy
    @project = current_user_or_guest_user.projects.find(params[:project_id])
    repository = @project.repositories.find(params[:id])
    repository.delete unless user_signed_in?

    redirect_to new_project_repository_path(@project), notice: 'Repository deleted successfully.'
  end

  private

  def repository_params
    params.
      require(:repository).
      permit(:fullname)
  end
end
