Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :endpoints, only: [:index, :show, :create, :update, :destroy]

      match '*unmatched', to: 'application#route_not_found', via: :all

      scope :mocked_endpoints do
        Endpoint.all.each do |endpoint|
          match endpoint.path, to: "mocked_endpoints##{endpoint.controller_action}", via: endpoint.converted_verb
        end
      end
    end
  end
end
