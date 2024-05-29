# frozen_string_literal: true

module Api
  module V1
    class EndpointsController < ApplicationController
      rescue_from ActionController::RoutingError, with: :route_not_found
      before_action :fetch_endpoint, only: %i[show update destroy]
      after_action :update_endpoints, only: %i[create update destroy]

      def index
        endpoints = Endpoint.all
        render json: endpoints
      end

      def show
        render json: @endpoint
      end

      def create
        endpoint = Endpoint.new(endpoint_params)
        if endpoint.valid?
          endpoint.save
          render json: { message: 'Endpoint created successfully' }, status: :created
        else
          render json: { errors: endpoint.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @endpoint.update(endpoint_params)
          render json: @endpoint
        else
          render json: { errors: @endpoint.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @endpoint.destroy
      end

      private

      def fetch_endpoint
        @endpoint = Endpoint.find(params[:id])
      end

      def endpoint_params
        params.require(:endpoint).permit(:path, :verb)
      end

      def update_endpoints
        MockedEndpointsService.update_all
      end
    end
  end
end
