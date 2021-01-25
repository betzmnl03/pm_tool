class TasksController < ApplicationController

    before_action :authenticate_user!
    before_action :authorize_user!,only:[:edit,:update,:destroy]

    before_action :find_project_id, only:[:index, :create, :edit, :update, :destroy]
    def new
        @task = Task.new
    end

    def index
        @task = Task.new
        render "tasks/new"
        
    end
    def create
        @task = Task.new task_params
        
        @task.project = @project
        @task.user = current_user
        @task.save

        @tasks = Task.all.order(created_at: :DESC)
        redirect_to project_path(@project)
    end

    def edit
        @task = Task.find params[:id]
    end
    def update
        @task = Task.find params[:id]
        if @task.update task_params
            redirect_to project_path(@project)
        end

    end
    def destroy
        @task = Task.find params[:id]
        @task.delete
        redirect_to project_path(@project)
    end

    private

    def task_params
        params.require(:task).permit(:title, :due_date, :completed)
    end

    def find_project_id
        @project = Project.find params[:project_id]
    end

    def authorize_user!
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @question)
    end

end
