class ProjectsController < ApplicationController
  # TODO: uncomment this after RailsRumble (guest user)
  # before_filter :authenticate_user!

  def index
    @projects = current_user_or_guest_user.projects
  end

  def show
    @project = current_user_or_guest_user.projects.includes(:repositories).find(params[:id])
    @repositories = @project.repositories
    @approval_emoji = Emoji.new(@project.approval_emoji)
    @repository = Repository.new
    @project_review = ProjectUserReview.new(@project, current_user_or_guest_user)
  end

  def new
    @project = Project.new
    load_emojis
  end

  def create
    @project = current_user_or_guest_user.projects.build(project_params)

    # TODO: remove this after RailsRumble (guest user)
    if !user_signed_in? || @project.save
      redirect_to projects_path
    else
      load_emojis
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
    load_emojis

    render 'new'
  end

  def update
    @project = Project.find(params[:id])

    # TODO: remove this after RailsRumble (guest user)
    if !user_signed_in? || @project.update_attributes(project_params)
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    # TODO: remove this after RailsRumble (guest user)
    @project.destroy unless user_signed_in?

    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :required_approvals, :approval_emoji)
  end

  def load_emojis
    @default_emoji = Emoji.new(@project.approval_emoji)
    @suggested_emojis = Repository::SUGGESTED_EMOJIS.map { |e| Emoji.new(e) }
    @all_emojis = Emoji.all
  end
end
