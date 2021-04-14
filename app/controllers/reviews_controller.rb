class ReviewsController < ApplicationController

    def show
        byebug
        @review = Review.find(params[:id])
    end

end