class ReviewsController < ApplicationController

    def show
        @review = Review.find(params[:id])
    end

    def index
        @reviews = Review.all
    end
end