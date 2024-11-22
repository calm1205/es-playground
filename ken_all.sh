#!/bin/bash

# 入力CSVファイルと出力JSONファイル
INPUT_FILE="fixtures/ken_all.csv"
OUTPUT_FILE="fixtures/ken_all.json"

# CSVをJSONに変換
awk -F ',' '
{
    print "{ \"index\": { \"_id\": \"" NR "\" } }"
    printf "{"
    for (i = 1; i <= NF; i++) {
        if (i < 10) {
            printf " \"field%d\": \"%s\"", i, $i
        }
        if (i < 9) {
            printf ","
        }
    }
    print " }"
}' "$INPUT_FILE" | sed '$s/},/}/' > "$OUTPUT_FILE"

echo "JSONデータが $OUTPUT_FILE に保存されました。"
