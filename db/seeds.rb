# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Endpoint.create!([
                   { path: '/some_post_endpoint', verb: 'POST' },
                   { path: '/some_patch_endpoint', verb: 'PATCH' },
                   { path: '/some_update_endpoint', verb: 'UPDATE' },
                   { path: '/some_delete_endpoint', verb: 'DELETE' },
                   { path: '/some_get_endpoint', verb: 'GET' }
                 ])
