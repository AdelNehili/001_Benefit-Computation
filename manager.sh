#!/bin/bash

# Configuration
network_name="benefits-net"
db_container="benefits-db"
app_container="benefits-app"
db_user="benefits_user"
db_pass="benefits_pass"
db_name="benefits_db"
db_image="postgres"
app_image="benefits-calculator"
db_port=5432
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

# Step 3: Build new app.properties file dynamically if needed
echo "📝 Verifying application properties..."
cat << EOF > application-dev.properties
spring.datasource.url=jdbc:postgresql://$db_container:$db_port/$db_name
spring.datasource.username=$db_user
spring.datasource.password=$db_pass
spring.datasource.driver-class-name=org.postgresql.Driver

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
EOF

# Step 4: Start Spring Boot app container
if docker ps -a --format '{{.Names}}' | grep -q "^$app_container$"; then
  echo "♻️ Removing old Spring Boot container '$app_container'..."
  docker rm -f "$app_container" > /dev/null
fi

echo "🚀 Starting Spring Boot application container '$app_container'..."
docker run --name "$app_container" \
  --network "$network_name" \
  -p "$app_port:$app_port" \
  -e SPRING_PROFILES_ACTIVE=dev \
  -v "$(pwd)/application-dev.properties":/app/config/application-dev.properties \
  "$app_image"

