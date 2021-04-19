class ReviewsController < ApplicationController
    before_action :set_review, only: [:show, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:destroy]

    def show
    end

    def index
        @reviews = Review.paginate(page: params[:page], per_page: 10)
    end
    
    def new
        @review = Review.new()
    end
    
    def create
        @review = Review.new(review_params())
        @review.user = current_user
        if @review.save()
            flash[:notice] = "Review Posted Successfully."
            redirect_to review_path(@review)
        else
            render 'new'
        end
    end
    
    def destroy
        @review.destroy()
        redirect_to reviews_path
    end
    
    private 
    
    def set_review
        @review = Review.find(params[:id])
    end
    
    def review_params
        params.require(:review).permit(:title, :body)
    end
end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :body)
  end

  def require_same_user
      if current_user.id != @review.user.id
          flash[:alert] = "You can only delete your own reviews."
          redirect_to @review
      end
  end