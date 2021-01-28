class ProjectsController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only:[:edit,:update,:destroy]
    before_action :find_project, only:[:show, :edit, :update, :destroy]
    def index
        @projects = Project.all.order(created_at: :DESC)
    end

    def new
        @project = Project.new
    end

    def create
        @project=Project.new project_params
        @project.user = current_user
        if @project.save
            flash[:notice]="Project created successfully."
            redirect_to project_path(@project.id)
        else
            render :new
        end
    end 
    def show
        @project = Project.find params[:id]
        @tasks = @project.tasks.order(created_at: :DESC)
        @task = Task.new
        @discussion = Discussion.new 
        @discussion.project = @project
        # @discussion.save
        @tasks_pie=@project.tasks.group(:completed)
        @completed = @tasks_pie.count[true]
        @inprogress= @tasks_pie.count[false]
        @favourite = @project.favourites.find_by_user_id current_user if user_signed_in?
       
    end

    def favourited
        @favourites = current_user.favourited_projects.order('favourites.created_at DESC')
    end

    def update
        if @project.update project_params
            redirect_to project_path(@project.id), notice: "Project edited successfully."
        else
            render :edit
        end
    end

    def destroy
            @project.destroy
            redirect_to projects_path, notice: "Project Deleted"
       
    end

    private
    def find_project
        @project = Project.find params[:id]
    end

    def project_params
        params.require(:project).permit(:title, :description, :due_date)
    end

    def authorize_user!
        @project = Project.find params[:id]
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @project)
    end
end
