class Civic < ActiveRecord::Base

  def channels
  responsex = @response["officials"]
  channels = []
  responsex.each do |q|
    channels << responsex["channels"]
    end
    byebug
  end

end
