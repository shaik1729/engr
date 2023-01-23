class ApplicationController < ActionController::Base
    class Unauthorized < StandardError; end
    rescue_from Unauthorized, :with => :handle_exception
    
    WillPaginate.per_page = 10

    def handle_exception
        redirect_to '/unauthorized.html'
    end
end
