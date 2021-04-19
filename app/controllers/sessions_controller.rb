class SessionsController < ApplicationController

    def new
    end
    
    def create
        user = User.find_by(email: params[:session][:email].downcase())
        if user and user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = "Logged in successfully"
            redirect_to user
        
        else
            flash.now[:alert] = "Incorrect login details"
            render 'new'
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:notice] = "You are now logged out."
        redirect_to root_path
    end

end