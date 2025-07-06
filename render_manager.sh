#!/bin/bash

# --- Load .env securely ---
if [[ -f .env ]]; then
  # shellcheck disable=SC1091
  source .env
  RENDER_DB_HOST=$(echo $RENDER_DB_HOST | tr -d '\r')
  RENDER_DB_USER=$(echo $RENDER_DB_USER | tr -d '\r')
  RENDER_DB_PASS=$(echo $RENDER_DB_PASS | tr -d '\r')
  RENDER_DB_NAME=$(echo $RENDER_DB_NAME | tr -d '\r')
  RENDER_DB_PORT=$(echo $RENDER_DB_PORT | tr -d '\r')
else
  echo "❌ Missing .env file. Aborting."
  exit 1
fi

# --- Configuration ---
app_container="benefits-app"
app_image="benefits-calculator"
app_port=8080

# --- Optional: Rebuild the image ---
if [[ "$1" == "update" ]]; then
  echo "🔄 Building updated Docker image: $app_image"
  docker build -t "$app_image" .
fi

# --- Remove existing container if it exists ---
if docker ps -a --format '{{.Names}}' | grep -q "^$app_container$"; then
  echo "♻️ Removing old container: $app_container"
  docker rm -f "$app_container" > /dev/null
fi

# --- Run the container ---
echo "🚀 Starting application container: $app_container"
docker run --name "$app_container" \
  -p "$app_port:$app_port" \
  -e SPRING_PROFILES_ACTIVE=dev \
  -e SPRING_DATASOURCE_URL="jdbc:postgresql://${RENDER_DB_HOST}:${RENDER_DB_PORT}/${RENDER_DB_NAME}" \
  -e SPRING_DATASOURCE_USERNAME="${RENDER_DB_USER}" \
  -e SPRING_DATASOURCE_PASSWORD="${RENDER_DB_PASS}" \
  "$app_image"

echo "📦 Using DB: $RENDER_DB_USER@$RENDER_DB_HOST:$RENDER_DB_PORT/$RENDER_DB_NAME"
