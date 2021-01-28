class TagsController < ApplicationController

    def index
        @tags= Tag.all.order(name: :asc)
       
    end

    def show
        @tag = Tag.find params[:id]
        @projects = @tag.projects.order(created_at: :desc)
    end
end
