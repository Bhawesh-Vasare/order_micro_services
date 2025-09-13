require 'httparty'

class ProductClient 
    include HTTParty

    base_uri 'http://localhost:3001'

    def self.get_product(product_id)
        byebug
        response = get("/products/#{product_id}") 
        if response.success?
            response.parsed_response
        else
            nil
        end

    end
end 