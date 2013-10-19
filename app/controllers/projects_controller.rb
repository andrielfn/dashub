class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      @projects = Project.all
      render 'index'
    else
      render 'new'
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
