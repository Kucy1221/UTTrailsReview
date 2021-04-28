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
        @trail = params[:trail]
    end
    
    def create
        @review = Review.new(review_params())
        @review.user = current_user
        
        if @review.save()
            flash[:notice] = "Review Posted Successfully."

            trail = Trail.find(@review.trail_id)
            revs = trail.reviews
            totalRating = 0
            revs.each do |rev|
                totalRating += rev.rating
            end
            avgRating = totalRating.to_d / trail.reviews.count.to_d
            trail.rating = avgRating
            if trail.save()
                flash[:notice] = "Trail Rating Adjusted"
            else
                flash[:alert] = "Trail Rating out-of-date"
            end

            redirect_to review_path(@review)
        else
            @trail = @review.trail_id
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
    params.require(:review).permit(:title, :body, :rating, :trail_id)
  end

  def require_same_user
      if current_user.id != @review.user.id && !current_user.admin?
          flash[:alert] = "You can only delete your own reviews."
          redirect_to @review
      end
  end

end