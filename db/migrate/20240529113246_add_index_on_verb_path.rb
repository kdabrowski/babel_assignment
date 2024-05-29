# frozen_string_literal: true

class AddIndexOnVerbPath < ActiveRecord::Migration[7.0]
  def change
    add_index :endpoints, %i[verb path], unique: true
  end
end
