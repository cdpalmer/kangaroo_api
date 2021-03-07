class SearchesController < ApplicationController
  def index
    searches = Search.all

    render json: searches
  end

  def create
    search = Search.new(search_params)
    search.save!

    render 200
  end

  private

  def search_params
    params.permit(:zip_code)
  end
end
