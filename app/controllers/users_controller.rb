class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :require_user, only: [:edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def show
        @reviews = @user.reviews.paginate(page: params[:page], per_page: 10)
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 10)
    end

    def new
        @user = User.new()
    end
    
    def edit
        if !logged_in? || @user.id != current_user.id
            redirect_to user_path(@user.id)
        end
    end
        
    def update
        if @user.update(user_params)
            flash[:notice] = "Your account was successfully updated."
            redirect_to user_path(@user.id)
        else
            render 'edit'
        end
    end
    
    def create
        @user = User.new(user_params())
        if @user.save()
            session[:user_id] = @user.id
            flash[:notice] = "Hi, " + @user.username + ", Welcome to Utah Trail Review!"
            redirect_to root_path
        else
            render 'new'
        end
    
    end
    
 
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def require_same_user
        if current_user.id != @user.id
            flash[:alert] = "You can only edit your own account"
            redirect_to @user
        end
    end

end