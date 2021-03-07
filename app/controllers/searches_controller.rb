class SearchesController < ApplicationController
  def index
    searches = Search.all

    render json: searches
  end

  def create
    search = Search.new(search_params)
    if search.valid?
      existing_record = Search.find_by(zip_code: search.zip_code)
      unless existing_record
        search.save! unless existing_record
        movie_service = MovieService.new
        movie_service.process_zipcode(search.zip_code)
      end

      render json: search, status: 200
    else
      render json: { error: 'Invalid zip code format' }, status: 422
    end
  end

  private

  def search_params
    params.permit(:zip_code)
  end
end
