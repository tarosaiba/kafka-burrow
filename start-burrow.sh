#!/bin/sh -e

## Assumed Variables
## - ZOOKEEPER_SERVER : 10.0.0.1:2181
## - KAFKA_SERVER : 10.0.0.2:9092
## - KAFKA_CLASS_NAME : kafka

## Set variables
if [[ -n "$KAFKA_SERVER" ]]; then
    sed -i "s/kafka:9092/$KAFKA_SERVER/g" "/etc/burrow/burrow.toml"
    unset KAFKA_SERVER
elif [[ -z "$KAFKA_SERVER" ]]; then
    echo "ERROR: No kafka servers configuration provided in environment."
    echo "       Please define KAFKA_SERVER"
    exit 1
fi

if [[ -n "$ZOOKEEPER_SERVER" ]]; then
    sed -i "s/zookeeper:2181/$ZOOKEEPER_SERVER/g" "/etc/burrow/burrow.toml"
    unset ZOOKEEPER_SERVER
elif [[ -z "$ZOOKEEPER_SERVER" ]]; then
    echo "ERROR: No zookeeper servers configuration provided in environment."
    echo "       Please define ZOOKEEPER_SERVER"
    exit 1
fi

exec /app/burrow --config-dir /etc/burrow
