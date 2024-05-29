# frozen_string_literal: true

class EndpointSerializer < ActiveModel::Serializer
  attributes :response

  def response
    {
      data: {
        type: 'endpoints',
        attributes: {
          verb: object.verb,
          path: object.path
        },
        response: {
          code: 200
        },
        headers: {
          "Content-Type": 'application/json'
        },
        body: '"{ "message": "Hello, world" }"'
      }
    }
  end
end
