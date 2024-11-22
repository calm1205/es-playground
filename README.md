# Elastic Search

```bash
# create index
curl -X PUT localhost:9200/initial_index -u elastic:password

# get index
curl localhost:9200/initial_index -u elastic:password

# delete index
curl -X DELETE "http://localhost:9200/old_index" -u elastic:password

# set mapping
curl -X PUT "http://localhost:9200/users_index" -H 'Content-Type: application/json' -d '{
  "mappings": {
    "properties": {
      "id": { "type": "integer" },
      "name": { "type": "text" },
      "age": { "type": "integer" },
      "email": { "type": "keyword" },
      "job": { "type": "text" }
    }
  }
}' -u elastic:password

# insert document
curl -X POST "http://localhost:9200/users_index/_bulk" -H "Content-Type: application/json" --data-binary @users.json -u elastic:password
```
