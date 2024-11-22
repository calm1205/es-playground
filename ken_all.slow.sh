#!/bin/bash

json_output="["

while IFS=, read -r field1 field2 field3 field4 field5 field6 field7 field8 field9 field10 ; do
    echo "field1: $field1"
    json_output="$json_output
    { \"index\": { \"_id\": \"$id\" } },
    {
        \"field1\": \"$field1\",
        \"field2\": \"$field2\",
        \"field3\": \"$field3\",
        \"field4\": \"$field4\",
        \"field5\": \"$field5\",
        \"field6\": \"$field6\",
        \"field7\": \"$field7\",
        \"field8\": \"$field8\",
        \"field9\": \"$field9\",
        \"field10\": \"$field10\"
    },"
done < fixtures/ken_all.csv

# 最後のカンマを削除
json_output=$(echo "$json_output" | sed '$ s/,$//')

# JSON配列の閉じ括弧を追加
json_output="$json_output
]"

# 結果を出力
echo "$json_output" > fixtures/ken_all.json