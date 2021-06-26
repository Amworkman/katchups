class Restaurant < ApplicationRecord    

    @@api_key = "#{ENV['YELP_API_KEY']}"

    @@headers = {
        headers: {
            "Authorization" => "Bearer #{@@api_key}"
        }
    }

    def self.location_restaurants(location)
        @search_url = "https://api.yelp.com/v3/businesses/search?location=#{location}&category=restaurants&limit=20&sort_by=best_match"
        HTTParty.get(@search_url, @@headers)
    end

    def self.katchup_restaurants(location, date="")
        @search_url = "https://api.yelp.com/v3/businesses/search?location=#{location}&category=restaurants&open_at=#{date}&limit=50&sort_by=best_match"
        HTTParty.get(@search_url, @@headers)
    end

    def self.single(restaurant_id)
        @details_url = "https://api.yelp.com/v3/businesses/#{restaurant_id}"
        HTTParty.get(@details_url, @@headers)
    end

end
