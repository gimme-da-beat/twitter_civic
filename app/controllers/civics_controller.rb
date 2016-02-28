class CivicsController < ApplicationController
  def index
    address = params["address"]
    @response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/representatives?address=#{address}&key=#{ENV["GOOGLE_KEY"]}")
    channels = []
    twitter_dirty = []
    twitter_refined = []
    @response["officials"].each do |qz|
      if qz["channels"] ==  nil
      elsif !qz["channels"].empty?
          qz["channels"].each do |y|
              y.each do |z|
                if z.include?("Twitter")
                twitter_dirty << y
                end
              end
          end
      end
    end
    twitter_dirty.each do |xxx|
      twitter_refined << xxx.values[1]
    end
    render json:twitter_refined
  end

  def show
  end

end
