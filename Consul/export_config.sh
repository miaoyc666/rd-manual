#!/bin/bash

if [ "$1" == '-h' ];
then
    echo Usage: ./export_config.sh [token]
    echo Example: ./export_config.sh cd76a0f7-5535-40cc-8696-073462accabc
    exit
fi

if [ $# -ne 1 ];
then
    echo Usage: ./export_config.sh [token]
    echo Example: ./export_config.sh cd76a0f7-5535-40cc-8696-073462accabc
    exit
fi

echo '#!/bin/bash

if [ $# -ne 1 ];
then
    echo Usage: ./env.sh [token]
    echo Example: ./env.sh cd76a0f7-5535-40cc-8696-073462accabc
    exit
fi

while read k v ;do
    if [ -z "$k" ]; then
        continue
    fi
    echo "$k = $v"
    CONSUL_HTTP_TOKEN=$1 consul kv put "${k}" "$v"
done << EOF' > env.sh

consul kv get -recurse -token=$1 | sed 's/\:/\ /' >> env.sh
echo EOF >> env.sh
