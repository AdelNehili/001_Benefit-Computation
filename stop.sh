#!/bin/bash

# Stop Spring Boot app
if [ -f social-benefits-calculator/app.pid ]; then
    PID=$(cat social-benefits-calculator/app.pid)
    echo "Stopping Spring Boot app (PID $PID)..."
    kill $PID 2>/dev/null && echo "Spring Boot app stopped."
    rm social-benefits-calculator/app.pid
else
    echo "No app.pid file found. Spring Boot app may not be running."
fi

# Stop Docker container
docker stop benefits-db >/dev/null 2>&1 && echo "Stopped Docker container 'benefits-db'." || echo "Container 'benefits-db' was not running."

# Free port 5432 (PostgreSQL)
PORT_5432_PID=$(lsof -t -i :5432)
if [ -n "$PORT_5432_PID" ]; then
    kill -9 $PORT_5432_PID && echo "Freed port 5432."
else
    echo "No process found on port 5432."
fi

# Free port 8080 (Spring Boot)
PORT_8080_PID=$(lsof -t -i :8080)
if [ -n "$PORT_8080_PID" ]; then
    kill -9 $PORT_8080_PID && echo "Freed port 8080."
else
    echo "No process found on port 8080."
fi

echo ""
echo "Checking phase"
#docker ps -a --filter "name=benefits-db"

docker ps -a
lsof -t -i :8080
lsof -t -i :5432