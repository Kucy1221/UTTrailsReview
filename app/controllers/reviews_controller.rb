class ReviewsController < ApplicationController
    before_action :set_review, only: [:show, :destroy]


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
