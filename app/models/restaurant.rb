class Restaurant < ApplicationRecord    

    @@api_key = "#{ENV['YELP_API_KEY']}" 
    @@url = "https://api.yelp.com/v3/graphql"  

    @@headers = {
        headers: {
            "Authorization" => "Bearer #{@@api_key}",
        }
    }

    @@fragment = <<-GRAPHQL
        business {
            id
            name
            price
            rating
            location {
                formatted_address
            }
            categories {
                title
            }
            photos
            display_phone
            url
            review_count
            is_closed
        }
        GRAPHQL
    

    def self.location_restaurants(location)
        HTTParty.post(
            @@url,
            headers: {
                "Authorization" => "Bearer #{@@api_key}",
                "content-type" => "application/graphql"
            },
            body: <<-GRAPHQL
            {
                search(location: "#{location}", categories: "restaurants", limit: 20, sort_by: "best_match") {
                    #{@@fragment}
                }
            }
            GRAPHQL
        )
    end

    def self.katchup_restaurants(location, date="", offset)
        HTTParty.post(
            @@url,
            headers: {
                "Authorization" => "Bearer #{@@api_key}",
                "content-type" => "application/graphql"
            },
            body: <<-GRAPHQL
            {
                search(location: "#{location}", categories: "restaurants", limit: 50, open_at: #{date}, offset: #{offset}, sort_by: "best_match") {
                    #{@@fragment}
                }
            }
            GRAPHQL
        )
    end

    def self.single(restaurant_id)
        @details_url = "https://api.yelp.com/v3/businesses/#{restaurant_id}"
        HTTParty.get(@details_url, @@headers)
    end

end
