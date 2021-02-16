class UsersController < ApplicationController

    before_action :authenticated_user!, only: [:edit, :show]

    def new
        @user = User.new
    end


    def create
        @user = User.new user_params
        if @user.errors.any?
           puts @user.errors.full_messages
        end
        if @user.save
            session[:user_id]=@user.id
            redirect_to root_path, notice: "Logged In!"
        else
            render :new
        end
    end


    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
