# README

To setup run:

```
bundle install
rake db:create
rake db:migrate
rake db:seed
```
To run th server:
```
rails s
```

To run specs
```
rspec
```

There are already example endpoints in the seed. Please look below for the generated curl calls to sed endpoints.

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
