class CivicsController < ApplicationController
  def index
    address = params["address"]
    network = params["network"]
    feature_display = Civic.new(address, network)
    feature_display.extract_network(network)
    feature_display.extract_state
    feature_display.extract_full_names_and_photos
    render json:feature_display.combiner
  end

  def show
  end

end
