class PlacesKeyController < ApplicationController

    def index 
        @key = "#{ENV['PLACES_KEY']}"
        render json: @key.to_json
    end

end