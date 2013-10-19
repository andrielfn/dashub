class RepositoriesController < ApplicationController
  def create
    project = Project.find(params[:project_id])
    repository = project.repositories.create(repository_params)

    redirect_to project_path(project)
  end

  private

  def repository_params
    params.require(:repository).permit(:name, :description, :url)
  end
end
