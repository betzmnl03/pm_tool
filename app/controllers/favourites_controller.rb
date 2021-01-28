class FavouritesController < ApplicationController



    def create
        project = Project.find params[:project_id]
        favourite = Favourite.new user: current_user, project: project
        if !can?(:favourite, project)
            flash[:alert] = "You can't favourite your own project"
        elsif favourite.save
          flash[:success] = "Project favourited!"
          redirect_to project
        else
          flash[:warning] = favourite.errors.full_messages.join(', ')

        end
    end


    def destroy
        favourite = Favourite.find params[:id]
        if can? :destroy, favourite
            favourite.destroy
            flash[:success] = "Unfavourited Project"
            redirect_to favourite.project
        else 
            flash[:alert] = "Could not favourite project"
            redirect_to favourite.project
        end
    end
end
