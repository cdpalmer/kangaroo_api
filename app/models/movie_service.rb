class MovieService
  def initialize(service = OnConnect.new)
    @remote_movie_service = service
  end

  def find_by_zipcode(zipcode)
    @remote_movie_service.find_by_zipcode(zipcode)
  end

  def parse_zipcode_payload(payload,zip)
    @remote_movie_service.parse_zipcode_payload(payload,zip)
  end
end
