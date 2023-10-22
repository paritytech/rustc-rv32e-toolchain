#!/usr/bin/env bash

echo "test: to_replace/to_replace/" > test-file1
echo "test: to_replace/to_replace/" > test-file2
sed -i'' -e 's#to_replace/to_replace/##g' test-*
cat test-file1
cat test-file2
