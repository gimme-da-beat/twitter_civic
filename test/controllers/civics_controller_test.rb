require 'test_helper'

class CivicsControllerTest < ActionController::TestCase
  test "should get index" do
    # address = params["address"]
    # civic1 = Civic.new(address:"5404+Shelbrooke+drive")
  get :index, address: "5404+shelbrooke+dr"

  # byebug

    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end


# party = params["party"]
#     district = params["district"]
#     hometown = params["hometown"]
#     name = params["name"]
#     candi = Candidate.create!(name: name, hometown: hometown, district: district, party: party)
