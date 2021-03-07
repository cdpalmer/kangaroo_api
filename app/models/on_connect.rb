class OnConnect
  require 'net/http'

  RADIUS_IN_MILES = '25'

  def initialize
    @endpoint = "http://data.tmsapi.com/v1.1/movies/showings/"
    @connection = Faraday.new(url: @endpoint) do |faraday|
      faraday.request   :url_encoded
      faraday.adapter   Faraday.default_adapter
    end
  end

  def find_by_zipcode(zip)
    today = Date.today.strftime("%Y-%m-%d")
    zip_endpoint = "?startDate=#{today}&zip=#{zip}&radius=#{RADIUS_IN_MILES}&units=mi&api_key=#{ENV["ONCONNECT_KEY"]}"
    output = @connection.get zip_endpoint
    output.body
  end
end
