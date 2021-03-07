require 'spec_helper'
require 'rails_helper'

describe "Search", type: :request do
  describe 'creates a new search' do
    it 'works' do
      post searches_path, params: { zip_code: '90210' }

      expect(response).to be_successful
      expect(Search.count).to eq(1)
    end
  end
end
