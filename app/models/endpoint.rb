# frozen_string_literal: true

class Endpoint < ApplicationRecord
  validates :verb, :path, presence: true
  validates :verb, presence: true,
                   inclusion: { in: %w[GET POST PUT DELETE UPDATE PATCH], message: '%{value} is not a valid verb' }
  validates_uniqueness_of :path, scope: :verb, case_insensitive: false
  validates :path, format: {
    with: %r{\A/(?:[a-zA-Z0-9_\-]+/)*[a-zA-Z0-9_\-]+\z}
  }

  before_validation :downcase_path

  def controller_action
    case verb
    when 'POST'
      :post
    when 'PATCH'
      :patch
    when 'UPDATE'
      :update
    when 'DELETE'
      :delete
    when 'GET'
      :get
    end
  end

  def converted_verb
    return verb.downcase.to_sym unless verb == 'UPDATE'

    :put
  end

  private

  def downcase_path
    return unless path

    self.path = path.downcase
  end

  def valid_verb
    errors.add(:verb, "'#{verb}' is not a valid verb") unless %w[GET POST PUT DELETE UPDATE].include?(verb)
  end
end
