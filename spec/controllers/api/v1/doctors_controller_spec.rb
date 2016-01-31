require 'rails_helper'

RSpec.describe Api::V1::DoctorsController, :type => :controller do

  describe 'GET search' do
    before { get :search, search_params }

    context 'when api call is successfull' do
      let(:search_params) { { 'name' => 'Doctor'} }
      it 'must respond with successfull response code and data' do
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['data']).to be_an(Array)
      end
    end
    
    context 'when api call is unsuccessful' do
      let(:search_params) { { 'sport' => 'football' } }
      it 'must respond with an error' do
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['meta']['error']).to eq(true)
        expect(JSON.parse(response.body)['meta']['http_status_code']).to eq(400)
        expect(JSON.parse(response.body)['data']).to be_nil
      end
    end
  end

end
