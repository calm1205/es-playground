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

<br/><br/>

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

<br/><br/>

## ES|QL

```elasticsearch
POST /_query?format=txt
{
  "query": """
    FROM users_index
     | WHERE job LIKE "Developer"
  """
}
```

<br/><br/>

## サンプルデータ

https://www.post.japanpost.jp/zipcode/dl/kogaki-zip.html

```bash
# ZIPファイルをダウンロード
curl https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip --output fixtures/ken_all.zip

# ZIPファイルを解凍
unzip fixtures/ken_all.zip -d fixtures/ken_all

# 文字コードを変換
iconv -t UTF-8 -f SHIFT-JIS fixtures/ken_all/KEN_ALL.CSV > fixtures/ken_all.csv

# CSVファイルをJSONに変換
./convert.sh

# インデックスを作成
curl -X PUT "http://localhost:9200/ken_all_index?pretty" -u elastic:password | jq .

# JSONファイルをElasticsearchにインポート
curl -X POST "http://localhost:9200/ken_all_index/_bulk?pretty" -H "Content-Type: application/json" --data-binary @fixtures/ken_all.json -u elastic:password | jq .
```
