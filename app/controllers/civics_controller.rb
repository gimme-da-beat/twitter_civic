class CivicsController < ApplicationController
  def index
    address = params["address"]
    @response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/representatives?address=#{address}&key=#{ENV["GOOGLE_KEY"]}")
    channels = []
    twitter_dirty = []
    twitter_refined = []
    combined = []
    state_from_google = ""
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




    @response["normalizedInput"].each do |xyz|
    state_from_google << xyz.second if xyz.include?("state")
    end

    response2 = HTTParty.get("http://openstates.org/api/v1/legislators/?state=#{state_from_google}&chamber=upper&apikey=05f88e0536684aa6a5b9b7c923e4b3d8")

    combined << response2
    combined << twitter_refined






    render json:combined
  end

  def show
  end

end
