# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :endpoints, only: %i[index show create update destroy]

      scope :mocked_endpoints do
        # The connection check prevents from failing at db setup. This one was tricky. I appreciate the torture :)
        ActiveRecord::Base.connection.data_source_exists?(:endpoints)
        Endpoint.all.each do |endpoint|
          match endpoint.path, to: "mocked_endpoints##{endpoint.controller_action}", via: endpoint.converted_verb
        end
      rescue ActiveRecord::NoDatabaseError
        return nil
      end
    end
  end
  # Mounted for 404 check before the controllers got loaded. This takes care of the scenarion when the page is not found
  # for mocked endpoints
  match '*unmatched', to: 'application#route_not_found', via: :all
end
