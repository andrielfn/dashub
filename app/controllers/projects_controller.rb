class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @projects = Project.all
  end

  def show
    @project = Project.includes(:repositories).find(params[:id])
    @repositories = @project.repositories
    @approval_emoji = Emoji.new(@project.approval_emoji)
    @repository = Repository.new
  end

  def new
    @project = Project.new
    @emojis = Emoji.all
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path
    else
      @emojis = Emoji.all
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
    @emojis = Emoji.all

    render 'new'
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(project_params)
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :required_approvals, :approval_emoji)
  end
end
