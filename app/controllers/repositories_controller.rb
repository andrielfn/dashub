class RepositoriesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @repository = Repository.new
    @repositories = @project.repositories
  end

  def create
    @project = Project.find(params[:project_id])
    @repository = @project.repositories.new(repository_params)

    if @repository.save
      redirect_to new_project_repository_path, notice: 'Repository created successfully.'
    else
      @repositories = @project.repositories
      render action: :new
    end
  end

  private

  def repository_params
    params.
      require(:repository).
      permit(:fullname)
  end
end
