class PlacesKeyController < ApplicationController
    skip_before_action :authorized
    def index 
        @key = "#{ENV['PLACES_KEY']}"
        render json: @key.to_json
    end

end