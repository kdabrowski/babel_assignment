require 'rails_helper'

RSpec.describe 'Endpoints API', type: :request do
  describe 'GET /api/v1/endpoints' do
    context 'when there are endpoints defined' do
      let!(:endpoint_1) { FactoryBot.create(:endpoint, path: '/my_first_path', verb: 'POST') }
      let!(:endpoint_2) { FactoryBot.create(:endpoint, path: '/my_second_path', verb: 'PATCH') }

      before { get '/api/v1/endpoints' }

      it 'returns all endpoints' do
        expect(json["endpoints"]).not_to be_empty
        expect(json["endpoints"].size).to eq(2)
      end
    end

    context 'when there are no endpoints defined' do
      before { get '/api/v1/endpoints' }

      it 'returns and empty array' do
        expect(json["endpoints"]).to eq([])
      end
    end
  end

  describe 'GET /api/v1/endpoints/:id' do
    let(:endpoint) { FactoryBot.create(:endpoint) }

    context 'when the param is correct' do
      before { get "/api/v1/endpoints/#{endpoint.id}" }

      it 'returns the endpoint' do
        expect(json['endpoint']).not_to be_empty
        expect(json['endpoint']['response']['data']['attributes']['path']).to eq(endpoint.path)
        expect(json['endpoint']['response']['data']['attributes']['verb']).to eq(endpoint.verb)
      end
    end

    context 'when the id is not correct' do
      before { get "/api/v1/endpoints/12345" }

      it 'returns an error message' do
        expect(json['errors']).to eq(
          [
            {
              "code" => "not_found",
              "detail"=>"Resource not found"
            }
          ]
        )
      end
    end
  end

  describe 'PATCH /api/v1/endpoints/:id' do
    let!(:endpoint) { FactoryBot.create(:endpoint, verb: 'POST') }
    let(:valid_attributes) { { verb: 'GET' } }

    before { patch "/api/v1/endpoints/#{endpoint.id}", params: { endpoint: valid_attributes } }

    it 'updates the endpoint' do
      updated_endpoint = Endpoint.find(endpoint.id)
      expect(updated_endpoint.verb).to eq('GET')
    end

    context 'when the id is not correct' do
      before { patch "/api/v1/endpoints/12345" }

      it 'returns an error message' do
        expect(json['errors']).to eq(
          [
            {
              'code' => 'not_found',
              'detail' => 'Resource not found'
            }
          ]
        )
      end
    end
  end

  describe 'DELETE /api/v1/endpoints/:id' do
    let!(:endpoint) { FactoryBot.create(:endpoint, verb: 'GET', path: '/some_endpoint') }

    before { delete "/api/v1/endpoints/#{endpoint.id}" }

    it 'deletes the endpoint' do
      expect(Endpoint.count).to eq(0)
    end

    it 'checks if the endpoint is no longer available' do
      get '/api/v1/some_endpoint'
      expect(response.code).to eq('404')
    end

    context 'when the id is not correct' do
      before { delete '/api/v1/endpoints/12345' }

      it 'returns an error message' do
        expect(json['errors']).to eq(
          [
            {
              'code' => 'not_found',
              'detail' => 'Resource not found'
            }
          ]
        )
      end
    end
  end

  describe 'POST /api/v1/endpoints' do
    let(:valid_attributes) { { path: '/new_endpoint', verb: 'POST' } }
    before { post '/api/v1/endpoints', params: { endpoint: valid_attributes } }

    context 'when the request is valid' do
      it 'creates a new endpoint' do
        expect(Endpoint.count).to eq(1)
        expect(response).to have_http_status(201)
        expect(json['message']).to eq("Endpoint created successfully")
      end

      it 'pings the new endpoint' do
        post '/api/v1/mocked_endpoints/new_endpoint'
        expect(json['message']).to eq('This is a post endpoint')
      end
    end

    context 'when creating a GET endpoint' do
      let(:valid_attributes) { { path: '/new_endpoint', verb: 'GET' } }

      it 'pings the new endpoint' do
        get '/api/v1/mocked_endpoints/new_endpoint'
        expect(json['message']).to eq('This is a get endpoint')
      end
    end

    context 'when creating a DELETE endpoint' do
      let(:valid_attributes) { { path: '/new_endpoint', verb: 'DELETE' } }

      it 'pings the new endpoint' do
        delete '/api/v1/mocked_endpoints/new_endpoint'
        expect(json['message']).to eq('This is a delete endpoint')
      end
    end

    context 'when creating a UPDATE endpoint' do
      let(:valid_attributes) { { path: '/new_endpoint', verb: 'UPDATE' } }

      it 'pings the new endpoint' do
        put '/api/v1/mocked_endpoints/new_endpoint'
        expect(json['message']).to eq('This is an update endpoint')
      end
    end

    context 'when creating a PATCH endpoint' do
      let(:valid_attributes) { { path: '/new_endpoint', verb: 'PATCH' } }

      it 'pings the new endpoint' do
        patch '/api/v1/mocked_endpoints/new_endpoint'
        expect(json['message']).to eq('This is a patch endpoint')
      end
    end

    context 'when trying to call a non existant endpoint' do
      it 'returns a 404 response' do
        get '/api/v1/noednpoint'
        expect(json['errors']).to eq(
          [
            {
              "code" => "not_found",
              "detail" => "Requested page `/api/v1/noednpoint` does not exist"
            }
          ]
        )
      end
    end

    context 'when the user is trying to create a duplicated endpoint' do
      it 'returns an error' do
        post '/api/v1/endpoints', params: { endpoint: valid_attributes }

        expect(json['errors']).to eq("path" => ["has already been taken"])
      end
    end
  end
end

# Helper method to parse JSON response
def json
  JSON.parse(response.body)
end
