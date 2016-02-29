class CivicsController < ApplicationController
  def index
    address = params["address"]
    feature_display = Civic.new(address)
    feature_display.extract_twitter
    feature_display.extract_state
    feature_display.extract_full_names_and_photos
    render json:feature_display.combiner
  end

  def show
  end

end
