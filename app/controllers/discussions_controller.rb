class DiscussionsController < ApplicationController
    
    before_action :authorize_user!,only:[:edit,:update,:destroy]
    before_action :authenticate_user!, except: [:index, :show]
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


    def destroy
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:id]
        # @discussion.comments.delete
        @discussion.delete
        
        redirect_to project_discussions_path(@project.id)
        
    end
    private

    def discussion_params
        params.require(:discussion).permit(:title, :body)
    end

    def authorize_user!
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @discussion)
    end


end
