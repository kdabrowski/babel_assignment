# frozen_string_literal: true
# This class is commont for all the mocked endpoints, the newly created endpoints are being all led to this controller

module Api
  module V1
    class MockedEndpointsController < ApplicationController
      def get
        render json: { message: 'This is a get endpoint' }
      end

      def post
        render json: { message: 'This is a post endpoint' }
      end

      def patch
        render json: { message: 'This is a patch endpoint' }
      end

      def put
        render json: { message: 'This is an update endpoint' }
      end

      def update
        render json: { message: 'This is an update endpoint' }
      end

      def delete
        render json: { message: 'This is a delete endpoint' }
      end
    end
  end
end
