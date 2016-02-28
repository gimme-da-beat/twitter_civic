class CivicsController < ApplicationController
  def index
    address = params["address"]
    @response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/representatives?address=#{address}&key=#{ENV["GOOGLE_KEY"]}")
    channels = []
    twitter_dirty = []
    twitter_refined = []
    combined = []
    state_from_google = ""
    full_names = []
    photo_url = []
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
      if xxx.values[1] == "whitehouse"
      else twitter_refined << xxx.values[1]
      end
    end

    @response["normalizedInput"].each do |xyz|
    state_from_google << xyz.second if xyz.include?("state")
    end

    response2 = HTTParty.get("http://openstates.org/api/v1/legislators/?state=#{state_from_google}&chamber=upper&apikey=05f88e0536684aa6a5b9b7c923e4b3d8")



    response2.each do |zzz|
      zzz.each do |yyy|
      full_names << yyy.second if yyy.include?("full_name")
      photo_url << yyy.second if yyy.include?("photo_url")
      end
    end
 # byebug

    combined << full_names
    combined << photo_url
    combined << twitter_refined






    render json:combined
  end

  def show
  end

end
