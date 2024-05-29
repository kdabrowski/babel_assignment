require 'rails_helper'

RSpec.describe Api::V1::EndpointsController, type: :controller do
  describe '#index' do
    subject { get :index }

    let!(:endpoint_1) { FactoryBot.create(:endpoint, path: '/my_first_path', verb: 'POST') }
    let!(:endpoint_2) { FactoryBot.create(:endpoint, path: '/my_second_path', verb: 'PATCH') }

    it 'returns the requested endpoint' do
      expect(JSON.parse(subject.body)['endpoints']).to include(
        {'id' => endpoint_1.id, 'path' => endpoint_1.path, 'verb' => endpoint_1.verb},
        {'id' => endpoint_2.id, 'path' => endpoint_2.path, 'verb' => endpoint_2.verb}
      )
      binding.pry
    end
  end

  describe '#show' do
    subject { get :show, params: { id: endpoint.id } }
    let(:endpoint) { FactoryBot.create(:endpoint) }

    it 'returns the requested endpoint by id' do
      expect(JSON.parse(subject.body)['endpoint']).to include('path' => endpoint.path, 'verb' => endpoint.verb)
    end
  end

  describe '#update' do
    subject { patch :update, params: { id: endpoint.id, endpoint: { verb: 'GET' } } }
    let!(:endpoint) { FactoryBot.create(:endpoint, verb: 'POST') }

    it 'updates the endpoint param' do
     expect {
        subject
      }.to change { endpoint.reload.verb }.from('POST').to('GET')
    end

    it 'updates the routes' do
      subject
      expect(Rails.application.routes.routes.map { |route| { path: route.path.spec.to_s, verb: route.verb } })
        .to include(path: "/mocked_endpoints/#{endpoint.path}(.:format)", verb: 'GET')
    end
  end

  describe '#delete' do
    let!(:endpoint) { FactoryBot.create(:endpoint) }

    it 'deletes the endpoint' do
      expect { delete :destroy, params: { id: endpoint.id } }.to change { Endpoint.count}.from(1).to(0)
      expect(Rails.application.routes.routes.map { |route| { path: route.path.spec.to_s, verb: route.verb} })
        .not_to include(path: "//mocked_endpoints/#{endpoint.path}(.:format)", verb: endpoint.verb)
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          endpoint: {
            path: '/new_endpoint_post',
            verb: 'POST'
          }
        }
      end

      it 'creates an endpoint and returns a success message' do
        expect { post :create, params: valid_params }.to change { Endpoint.count }.from(0).to(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Endpoint created successfully')
        expect(Rails.application.routes.routes.map { |route| { path: route.path.spec.to_s, verb: route.verb} })
          .to include(path: '/mocked_endpoints/new_endpoint_post(.:format)', verb: 'POST')
        expect(Rails.application.routes.routes.map { |route| route.verb }).to include('POST')
      end
    end
  end
end
