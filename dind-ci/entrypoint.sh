#!/bin/sh
# Start the Docker daemon in the background
dockerd-entrypoint.sh &

# Wait for the Docker daemon to be ready
until docker info >/dev/null 2>&1; do
  echo "Waiting for Docker daemon..."
  sleep 1
done

# Keep the container running or execute the passed command
exec "$@"