#!/bin/bash
cd social-benefits-calculator

mvn clean install || exit 1

docker start benefits-db >/dev/null

# Optionally, wait for DB to become available
echo "Waiting for PostgreSQL to be ready..."
until pg_isready -h localhost -p 5432 -U benefits_user; do
  sleep 1
done

mvn spring-boot:run -Dspring-boot.run.profiles=dev