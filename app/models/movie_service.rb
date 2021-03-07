class MovieService
  def initialize(service = OnConnect.new)
    @remote_movie_service = service
  end

  def process_zipcode(zipcode)
    @remote_movie_service.process_zipcode(zipcode)
  end
end
