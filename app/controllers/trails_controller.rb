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

    #[:show, :index, :new, :create, :destroy]

    def show 
    end

    def index
    end

    def create 
    end
    
    def destroy
    end
    
end
