# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :endpoints, only: %i[index show create update destroy]

      scope :mocked_endpoints do
        ActiveRecord::Base.connection.data_source_exists?(:endpoints)
        Endpoint.all.each do |endpoint|
          match endpoint.path, to: "mocked_endpoints##{endpoint.controller_action}", via: endpoint.converted_verb
        end
      rescue ActiveRecord::NoDatabaseError
        return nil
      end
    end
  end
  match '*unmatched', to: 'application#route_not_found', via: :all
end
