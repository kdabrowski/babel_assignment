# frozen_string_literal: true
# The class updates the routes as called. Unfortunatell I did not come up with a more elegant solution to load the routes
# while in run time.

class MockedEndpointsService
  def self.update_all
    Rails.application.routes_reloader.reload!

    Rails.application.routes.draw do
      namespace :api do
        namespace :v1 do
          resources :endpoints, only: %i[index show create update destroy]

          scope :mocked_endpoints do
            Endpoint.all.each do |endpoint|
              match endpoint.path, to: "mocked_endpoints##{endpoint.controller_action}", via: endpoint.converted_verb
            end
          end
        end
      end

      match '*unmatched', to: 'application#route_not_found', via: :all
    end
  end
end
