#!/bin/bash

while read k v ;do
    if [ -z "$k" ]; then
        continue
    fi
    echo "$k = $v"
    consul kv put "${k}" "$v"
done <<EOF
test/test miaoyc1234
EOF
