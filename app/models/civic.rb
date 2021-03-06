class Civic < ActiveRecord::Base
  def initialize(address, network)
    @response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/representatives?address=#{address}&key=#{ENV["GOOGLE_KEY"]}")
    @combined = []
    @state_from_google = ""
    @full_names = []
    @photo_url = []
    @network_refined = []
  end

  def extract_network(network)
    network_dirty = []
    @response["officials"].each do |qz|
      if qz["channels"] ==  nil
      elsif !qz["channels"].empty?
        qz["channels"].each do |y|
          y.each do |z|
            if z.include?(network)
              network_dirty << y
            end
          end
        end
      end
    end
    network_dirty.each do |xxx|
      if xxx.values[1] == "whitehouse" || xxx.values[1] == "+whitehouse"
      else
        @network_refined << xxx.values[1]
      end
    end
  end

  def extract_state
    @response["normalizedInput"].each do |xyz|
    @state_from_google << xyz.second if xyz.include?("state")
    end
  end



  def extract_full_names_and_photos
    leg_response = HTTParty.get("http://openstates.org/api/v1/legislators/?state=#{@state_from_google}&apikey=#{ENV["LEG_KEY"]}")
    leg_response.each do |zzz|
      zzz.each do |yyy|
      @full_names << yyy.second if yyy.include?("full_name")
      @photo_url << yyy.second if yyy.include?("photo_url")
      end
    end
  end

  def combiner
    @combined << @network_refined
    @combined << @full_names
    @combined << @photo_url
  end

end
