class CivicsController < ApplicationController
  def index
    address = params["address"]
    @response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/representatives?address=#{address}&key=#{ENV["GOOGLE_KEY"]}")

    # final = @response.find_twitter

    render json:@response
  end

  def show
  end
end
