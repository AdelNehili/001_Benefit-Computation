#!/bin/bash

./stop.sh

# Configuration
network_name="benefits-net"

db_container="benefits-db"
db_image="postgres"
db_user="benefits_user"
db_pass="benefits_pass"
db_name="benefits_db"

db_port=5432

app_container="benefits-app"
app_image="benefits-calculator"
app_port=8080

# Step 1: Create network if not exists
if ! docker network ls | grep -q "$network_name"; then
  echo "🔧 Creating Docker network '$network_name'..."
  docker network create "$network_name"
else
  echo "✅ Docker network '$network_name' already exists."
fi

# Step 2: Start PostgreSQL container
if ! docker ps -a --format '{{.Names}}' | grep -q "^$db_container$"; then
  echo "🚀 Creating and starting PostgreSQL container '$db_container'..."
  docker run --name "$db_container" \
    --network "$network_name" \
    -e POSTGRES_USER="$db_user" \
    -e POSTGRES_PASSWORD="$db_pass" \
    -e POSTGRES_DB="$db_name" \
    -p "$db_port:$db_port" \
    -d "$db_image"
else
  echo "✅ PostgreSQL container '$db_container' already exists. Starting it..."
  docker start "$db_container" > /dev/null
fi

# Step 3: Build image if requested
case "$1" in
  update)
    echo "🔄 Building updated Docker image: $app_image"
    docker build -t "$app_image" .
    ;;
esac

# Step 4: Remove old app container if exists
if docker ps -a --format '{{.Names}}' | grep -q "^$app_container$"; then
  echo "♻️ Removing old Spring Boot container '$app_container'..."
  docker rm -f "$app_container" > /dev/null
fi

# Step 5: Run Spring Boot app container with ENV VARS (no config file!)
echo "🚀 Starting Spring Boot application container '$app_container'..."
docker run --name "$app_container" \
  --network "$network_name" \
  -p "$app_port:$app_port" \
  -e SPRING_PROFILES_ACTIVE=dev \
  -e DB_URL=jdbc:postgresql://$db_container:$db_port/$db_name \
  -e DB_USER=$db_user \
  -e DB_PASS=$db_pass \
  "$app_image"
