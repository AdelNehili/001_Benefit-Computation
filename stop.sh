#!/bin/bash

if [ -f social-benefits-calculator/app.pid ]; then
    PID=$(cat social-benefits-calculator/app.pid)
    echo "Stopping Spring Boot app (PID $PID)..."
    kill $PID
    rm social-benefits-calculator/app.pid
else
    echo "No Spring Boot PID file found in background."
fi

echo "Stopping Docker container (benefits-db)..."
docker stop benefits-db >/dev/null

#PID=$(lsof -t -i :8080) && kill -9 $PID && echo "Killed process $PID" || echo "No process found on port 8080"



