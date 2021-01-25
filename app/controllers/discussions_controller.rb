class DiscussionsController < ApplicationController
    
    
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only:[:edit,:update,:destroy]

    def new
        @dicussion = Dicussion.new

    end
    
    def create
        @project = Project.find params[:project_id]
        @discussion = Discussion.new discussion_params
        @discussion.project = @project
        @discussion.user = current_user
        @discussion.save
        redirect_to project_discussions_path(@project.id)

    end

    def index
        @project = Project.find params[:project_id]
        @discussions = @project.discussions.order(created_at: :desc)
    
    end

    def show
        # @discussion = Discussion.find params[:discussion_id]
        @project = Project.find params[:project_id]
        @discussions = @project.discussions.order(created_at: :desc)
        @comments = @discussion.comments.order(created_at: :desc)

    end

    def edit
        @project = Project.find params[:project_id]
        @tasks = @project.tasks.order(created_at: :DESC)
        @tasks_pie=@project.tasks.group(:completed)
        @completed = @tasks_pie.count[true]
        @inprogress= @tasks_pie.count[false]

    end

    def update
        if @discussion.update discussion_params
        redirect_to project_discussions_path(@project.id)
        else 
            render :edit
        end
    end

    def destroy
        @discussion.destroy
        redirect_to project_discussions_path(@project.id), notice: "Discussion Deleted"    
    end
    private

    def discussion_params
        params.require(:discussion).permit(:title, :body)
    end

    def authorize_user!
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:id]
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @discussion) || can?(:crud, @project)
    end


end
