class MoviesController < ApplicationController
  def index
    render json: { error: 'Invalid sort option' }, status: 422 and return if invalid_sort?

    movies = Movie.all
    if ['asc', 'desc'].include?(movie_params['sort'])
      movies = movies.order(title: movie_params['sort'].to_sym)
    end

    render json: movies
  end

  def invalid_sort?
    movie_params['sort'] && !['asc', 'desc'].include?(movie_params['sort'])
  end

  def movie_params
    params.permit(:sort)
  end
end
