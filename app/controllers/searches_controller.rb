class SearchesController < ApplicationController
  def index
    searches = Search.all

    render json: searches
  end

  def create
    wipe_old_data if Search.last && !Search.last.created_at.today?

    search = Search.new(search_params)
    if search.valid?
      output = {}
      existing_record = Search.find_by(zip_code: search.zip_code)

      if existing_record
        showtimes = existing_record.theaters.map(&:showtimes).flatten.uniq
        output = {
          zip_code: existing_record.zip_code,
          found_movies: showtimes.map(&:movie).uniq.count,
          found_theaters: existing_record.theaters.count,
          found_showtimes: showtimes.count
        }
      else
        search.save!
        movie_service = MovieService.new
        summary = movie_service.process_zipcode(search.zip_code)

        output = {
          zip_code: search.zip_code,
          found_movies: summary[:movies].count,
          found_theaters: summary[:theaters].count,
          found_showtimes: summary[:showtimes].count
        }
      end
      render json: output, status: 200
    else
      render json: { error: 'Invalid zip code format' }, status: 422
    end
  end

  private

  def search_params
    params.permit(:zip_code)
  end

  def wipe_old_data
    Search.destroy_all
    Showtime.destroy_all
    Movie.destroy_all
  end
end
