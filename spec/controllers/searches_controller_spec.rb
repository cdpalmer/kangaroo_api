require 'spec_helper'
require 'rails_helper'

describe "Search", type: :request do
  describe '#create' do
    it 'works' do
      zip = '90210'
      expect_any_instance_of(MovieService).to receive(:process_zipcode)
      post searches_path, params: { zip_code: zip }

      expect(response.code).to eq("200")
      payload = JSON.parse(response.body)
      expect(payload['zip_code']).to eq(zip)
      expect(Search.count).to eq(1)
    end

    it 'fails with non zip format' do
      post searches_path, params: { zip_code: 'deadbeef' }

      expect(response.code).to eq("422")
      payload = JSON.parse(response.body)
      expect(payload['error']).to eq('Invalid zip code format')
      expect(Search.count).to eq(0)
    end

    it 'does not create repeated records' do
      zip = '90210'
      3.times do
        post searches_path, params: { zip_code: zip }
      end

      expect(response.code).to eq("200")
      expect(Search.count).to eq(1)
    end

    it 'generates movie, showtime, and theater records' do
      expect_any_instance_of(Faraday::Connection).to receive(:get) { OpenStruct.new(body: OnConnectWebmock.zipcode_response) }
      zip = '90210'
      post searches_path, params: { zip_code: zip }

      # counts taken off webmock data
      expect(Movie.count).to eq(9)
      expect(Theater.count).to eq(7)
      expect(Showtime.count).to eq(89)
    end
  end
end
