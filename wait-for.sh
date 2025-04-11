#!/bin/sh

HOST="$1"
PORT="$2"
shift 2
CMD="$@"

echo "Waiting for $HOST:$PORT..."

while ! nc -z "$HOST" "$PORT"; do
  sleep 1
done

echo "Postgres is up - executing command"
exec $CMD