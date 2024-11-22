# Elastic Search

## URL

- Elastic Search: http://localhost:9200
- Kibana: http://localhost:5601

## REST API

```bash
# create index
curl -X PUT "localhost:9200/users_index?pretty" -u elastic:password

# get index
curl -X GET "localhost:9200/users_index?pretty" -u elastic:password | jq .

# get index all
curl -X GET "localhost:9200/_cat/indices?pretty" -u elastic:password

# delete index
curl -X DELETE "http://localhost:9200/users_index?pretty" -u elastic:password | jq .

# set mapping
curl -X PUT "http://localhost:9200/users_index?pretty" -H 'Content-Type: application/json' -d '{
  "mappings": {
    "properties": {
      "id": { "type": "integer" },
      "name": { "type": "text" },
      "age": { "type": "integer" },
      "email": { "type": "keyword" },
      "job": { "type": "text" }
    }
  }
}' -u elastic:password | jq .

# insert document
curl -X POST "http://localhost:9200/users_index/_bulk?pretty" -H "Content-Type: application/json" --data-binary @fixtures/users.json -u elastic:password | jq .

# search document
curl "http://localhost:9200/users_index/_search?q=25&pretty" -u elastic:password | jq .

# search document fuzzy
curl "http://localhost:9200/users_index/_search?pretty" -u elastic:password -H 'Content-Type: application/json' -d' {
  "query": {
    "match": {
      "job": {
        "query": "Engineer",
        "fuzziness": "0"
      }
    }
  }
} ' | jq .
```

## Query DSL

```elasticsearch
GET /users_index/_search?q=25

GET _cat/indices?v

GET /users_index/_search
{
  "query": {
    "match": {
      "job": {
        "query": "Dev",
        "fuzziness": 2
      }
    }
  }
}
```
