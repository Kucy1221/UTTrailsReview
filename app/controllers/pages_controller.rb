class PagesController < ApplicationController
    def home
        if logged_in?
            redirect_to about_path
        end
    end
    
    def about
    end
end
