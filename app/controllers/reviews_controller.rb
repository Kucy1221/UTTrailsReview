class ReviewsController < ApplicationController

    def show
        @review = Review.find(params[:id])
    end

    def index
        @reviews = Review.all
    end
    
    def new
        @review = Review.new
    end
    
    def create
        @review = Review.new(params.require(:review).permit(:title, :body))
        if @review.save
            flash[:notice] = "Review Posted Successfully."
            redirect_to reviews_path(@review)
        else
            render 'new'
        end
    end
    
    def destroy
        @review = Review.find(params[:id])
        @review.destroy
        redirect_to reviews_path
    end
end
