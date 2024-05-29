# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

CURL calls for the seeded endpoints:
```
# POST request
curl -X POST http://127.0.0.1:3000/api/v1/mocked_endpoints/some_post_endpoint \
     -H "Content-Type: application/json" \
     -d '{"key": "value"}'
echo -e "\n"

# PATCH request
curl -X PATCH http://127.0.0.1:3000/api/v1/mocked_endpoints/some_patch_endpoint \
     -H "Content-Type: application/json" \
     -d '{"key": "value"}'
echo -e "\n"

# UPDATE
curl -X PUT http://127.0.0.1:3000/api/v1/mocked_endpoints/some_update_endpoint \
     -H "Content-Type: application/json" \
     -d '{"key": "value"}'
echo -e "\n"

# DELETE request
curl -X DELETE http://127.0.0.1:3000/api/v1/mocked_endpoints/some_delete_endpoint
echo -e "\n"

# GET request
curl -X GET http://127.0.0.1:3000/api/v1/mocked_endpoints/some_get_endpoint
echo -e "\n"
```

* ...
