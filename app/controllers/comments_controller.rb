class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user!,only:[:edit,:update,:destroy]
    before_action :find_discussion_params, only:[:create, :index,:destroy]

    def new
        @comment = Comment.new 
    end
    
    def create
       
        @comment = Comment.new comment_params
        @comment.discussion = @discussion
        @comment.user = current_user
        @comment.save
        @comments = @discussion.comments.order(created_at: :desc)
        redirect_final

    end

    def index
        @comment = Comment.new comment_params
        @comments = @discussion.comments.order(created_at: :desc)
        
    end

    def edit
        @discussion = Discussion.find params[:discussion_id]
        @discussions = @project.discussions.order(created_at: :desc)
       
    end
    def update
        @comment.update comment_params
        redirect_final
    end

    def destroy
        @comment.delete
        redirect_final
        
    end
    private

    def comment_params
        params.permit(:body)
    end

    def find_discussion_params
        @discussion = Discussion.find params[:discussion_id]
    end

    def redirect_final

        @project_id = @discussion.project_id
        @project = Project.find @project_id
        redirect_to project_discussions_path(@project.id)
    end

    def authorize_user!
        find_discussion_params
        @project_id = @discussion.project_id
        @comment = Comment.find params[:id]
        @project = Project.find @project_id
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @comment) || can?(:crud, @project)
    end

   
end
