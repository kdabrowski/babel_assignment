# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  def route_not_found
    render json: {
      errors: [
        {
          code: 'not_found',
          detail: "Requested page `#{request.path}` does not exist"
        }
      ]
    }, status: :not_found
  end

  def resource_not_found
    render json: {
      errors: [
        {
          code: 'not_found',
          detail: 'Resource not found'
        }
      ]
    }, status: :not_found
  end
end
