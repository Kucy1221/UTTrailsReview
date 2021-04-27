class TrailsController < ApplicationController

    def searchpage
    end

    def lookup
        @trails = Trail.new_lookup(params)
    end


end
