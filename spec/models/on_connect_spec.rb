require 'spec_helper'

describe OnConnect do
  describe '#process_zipcode' do
    let(:search) { Search.create(zip_code: '90210') }
    let(:onconnect_payload) { OnConnectWebmock.zipcode_response }
    let(:webmock_titles) {
      [
        "300: Rise of an Empire",
        "A Haunted House 2",
        "Bears",
        "Brick Mansions",
        "Captain America: The Winter Soldier",
        "Cesar Chavez",
        "Divergent",
        "Dom Hemingway",
        "Draft Day"
      ].sort
    }
    let(:webmock_theatres) {
      [
        "Elvis Cinemas Tiffany Plaza",
        "Continental Stadium 10 & RPX",
        "AMC Cherry Creek 8",
        "Regal River Point Stadium 14",
        "UA Colorado Center Stadium 9 & IMAX",
        "Mayan Theatre",
        "Greenwood Village"
      ].sort
    }

    before :each do
      expect_any_instance_of(Faraday::Connection).to receive(:get) { OpenStruct.new(body: onconnect_payload) }
      subject.process_zipcode(search.zip_code)
    end

    it 'creates the correct movies' do
      processed_movie_titles = Movie.all.map(&:title)

      expect( Movie.count ).to eq(webmock_titles.count)
      expect( processed_movie_titles.sort ).to eq(webmock_titles)
    end

    it 'creates the correct theatres' do
      processed_movie_theatres = Theater.all.map(&:title)

      expect( Theater.count ).to eq(webmock_theatres.count)
      expect( processed_movie_theatres.sort ).to eq(webmock_theatres)
    end

    it 'creates the correct showtimes' do
      processed_showtimes = Showtime.all

      expect( processed_showtimes.count ).to eq(89)
    end
  end

  describe '#calc_movie_length' do
    it 'calculates and sets movie length' do
      example_run_time  = 'PT01H34M'
      output = subject.calc_movie_length(example_run_time)

      expect( output ).to eq 94
    end
  end

  describe '#calc_time_from_epoch' do
    it 'returns correct seconds from epoch ' do
      example_time = '2014-04-27T14:40'
      epoch_time = Time.new(2014, 4, 27, 14, 40)
      output = subject.calc_time_from_epoch(example_time)

      expect( output ).to eq epoch_time.to_i
    end
  end
end
