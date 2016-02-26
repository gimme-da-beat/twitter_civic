class CivicsController < ApplicationController
  def index
    address = params["address"]
    @response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/representatives?address=#{address}&key=#{ENV["GOOGLE_KEY"]}")
    channels = []
    @response["officials"].each do |q|
      channels << q["channels"]
      end
      # byebug







    render json:channels

  end

  def show
  end

  # def channels
  # responsex = @response["officials"]
  # channels = []
  # responsex.each do |q|
  #   channels << responsex["channels"]
  #   end
  #   byebug
  # end



end
