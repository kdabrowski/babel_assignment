Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :endpoints, only: [:index, :show, :create, :update, :destroy]

      match '*unmatched', to: 'application#route_not_found', via: :all

      scope :mocked_endpoints do
        begin
          ActiveRecord::Base.connection.data_source_exists?(:endpoints)
          Endpoint.all.each do |endpoint|
            match endpoint.path, to: "mocked_endpoints##{endpoint.controller_action}", via: endpoint.converted_verb
          end
        rescue ActiveRecord::NoDatabaseError
          return nil
        end
      end
    end
  end
end
