#!/bin/bash

# プロトファイルの総数を取得
total_files=$(ls -1 proto/v1/*.proto | wc -l)
current=0

for file in proto/v1/*.proto; do
  ((current++))
  echo "[$current/$total_files] Generating $file..."
  npx buf generate "$file"
done

echo "Complete! Generated $total_files proto files."
