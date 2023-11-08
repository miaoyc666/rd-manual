#!/bin/bash

if [ "$1" == '-h' ];
then
    echo Usage: ./export_config.sh [token]
    echo Example: ./export_config.sh f7bf5763-1692-4fd7-8e51-50d4000a27e3
    exit
fi

if [ $# -ne 1 ];
then
    echo Usage: ./export_config.sh [token]
    echo Example: ./export_config.sh f7bf5763-1692-4fd7-8e51-50d4000a27e3
    exit
fi

echo '#!/bin/bash

if [ $# -ne 1 ];
then
    echo Usage: ./env.sh [token]
    echo Example: ./env.sh f7bf5763-1692-4fd7-8e51-50d4000a27e3
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
