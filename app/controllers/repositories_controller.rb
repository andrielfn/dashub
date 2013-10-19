class RepositoriesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @repository = Repository.new
    @repositories = @project.repositories
    @suggested_repos = SuggestedRepositories.new(current_user).repos
  end

  def create
    @project = Project.find(params[:project_id])
    @repository = @project.repositories.new(repository_params)

    access_availability = RepositoryAvailability.new(@repository)

    if access_availability.available_for?(current_user)
      if @repository.save
        redirect_to new_project_repository_path(@project), notice: 'Repository created successfully.'
        return
      end
    else
      flash.now[:alert] = "Couldn't find this repository :("
    end

    @repositories = @project.repositories(true)
    render action: :new
  end

  def destroy
    @project = Project.find(params[:project_id])
    repository = @project.repositories.find(params[:id])
    repository.delete

    redirect_to new_project_repository_path(@project), notice: 'Repository deleted successfully.'
  end

  private

  def repository_params
    params.
      require(:repository).
      permit(:fullname)
  end
end
