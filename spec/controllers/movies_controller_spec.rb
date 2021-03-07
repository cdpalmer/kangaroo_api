require 'spec_helper'
require 'rails_helper'

describe "Movies", type: :request do
  describe '#index' do
    it 'works' do
      allow_any_instance_of(Faraday::Connection).to receive(:get) { OpenStruct.new(body: OnConnectWebmock.zipcode_response) }
      OnConnect.new.process_zipcode('80222')
      get movies_path

      expect(response.code).to eq("200")
      payload = JSON.parse(response.body)
      expect(payload.count).to eq(9)
    end

    it 'sorts ascending' do
      allow_any_instance_of(Faraday::Connection).to receive(:get) { OpenStruct.new(body: OnConnectWebmock.zipcode_response) }
      OnConnect.new.process_zipcode('80222')
      get movies_path, params: { sort: :asc }

      expect(response.code).to eq("200")
      payload = JSON.parse(response.body)
      expected_titles = Movie.all.order(title: :asc).map(&:title)
      expect( payload.map{ |m| m['title'] } ).to eq(expected_titles)
    end

    it 'sorts descending' do
      allow_any_instance_of(Faraday::Connection).to receive(:get) { OpenStruct.new(body: OnConnectWebmock.zipcode_response) }
      OnConnect.new.process_zipcode('80222')
      get movies_path, params: { sort: :desc }

      expect(response.code).to eq("200")
      payload = JSON.parse(response.body)
      expected_titles = Movie.all.order(title: :desc).map(&:title)
      expect( payload.map{ |m| m['title'] } ).to eq(expected_titles)
    end

    it 'needs valid asc or desc sorting' do
      allow_any_instance_of(Faraday::Connection).to receive(:get) { OpenStruct.new(body: OnConnectWebmock.zipcode_response) }
      OnConnect.new.process_zipcode('80222')
      get movies_path, params: { sort: :hotels }

      expect(response.code).to eq("422")
    end
  end
end
