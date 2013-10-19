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

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    @projects = Project.all
    render 'index'
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
