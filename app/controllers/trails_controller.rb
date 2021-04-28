class TrailsController < ApplicationController

    def searchpage
    end

    def lookup
        if params[:primaryname].length > 0 || params[:recreationarea].length > 0 || params[:designateduses].length > 0
            @trails = Trail.new_lookup(params)
        else
            flash[:alert] = "Please enter search criteria"
            redirect_to trail_search_path
        end
    end

    def create
        @trail =  Trail.find_by(xid: params[:trail][:xid])
        if not @trail
            @trail = Trail.new(trail_params())
            @trail.rating = 0
            if @trail.save()
                #flash[:notice] = "You are the first to view " + @trail.primaryname + ", A profile for this trail has been generated."
            else
                flash[:alert] = "The profile for the trail was not successfully generated."
            end
        end
        redirect_to trail_path(@trail.id)
    end

    def show
        @trail = Trail.find(params[:id])
        revs = @trail.reviews
        totalRating = 0
        revs.each do |rev|
            totalRating += rev.rating
        end
        avgRating = totalRating.to_d / @trail.reviews.count.to_d
        @trail.rating = avgRating
        @trail.save

        @reviews = @trail.reviews.paginate(page: params[:page], per_page: 5)
    end

private

def trail_params
    params.require(:trail).permit(:primaryname, :xid, :hikedifficulty, :bikedifficulty, :designateduses, :recreationarea)
end


end
