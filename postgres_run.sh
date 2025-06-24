#!/bin/bash

docker_name="benefits-db"
db_user="benefits_user"
db_pass="benefits_pass"
db_name="benefits_db"

# Function to show usage
show_help() {
  cat << EOF
    Usage: $0 [command]

    Commands:
    create   Create and start a new PostgreSQL container
    start    Start the existing container
    query    Run SQL query: SELECT * FROM users;
    stop     Stop the container
    help     Show this help message

    Examples:
    $0 create
    $0 start
    $0 query
    $0 stop
EOF
}

# Handle input argument
case "$1" in
  create)
    if [ "$(docker ps -a -q -f name=$docker_name)" ]; then
      echo "Container '$docker_name' already exists."
    else
      echo "Creating and starting container '$docker_name'..."
      docker run --name $docker_name \
        -e POSTGRES_USER=$db_user \
        -e POSTGRES_PASSWORD=$db_pass \
        -e POSTGRES_DB=$db_name \
        -p 5432:5432 \
        -d postgres
    fi
    ;;
  start)
    if [ "$(docker ps -q -f name=$docker_name)" ]; then
      echo "Container '$docker_name' is already running."
    else
      echo "Starting container '$docker_name'..."
      docker start $docker_name
    fi
    ;;
  query)
    if [ "$(docker ps -q -f name=$docker_name)" ]; then
      echo "Running SQL query..."
      docker exec -it $docker_name psql -U $db_user -d $db_name -c "SELECT * FROM users;"
    else
      echo "Error: Container '$docker_name' is not running. Start it first with '$0 start'."
    fi
    ;;
  stop)
    if [ "$(docker ps -q -f name=$docker_name)" ]; then
      echo "Stopping container '$docker_name'..."
      docker stop $docker_name
    else
      echo "Container '$docker_name' is not running."
    fi
    ;;
  help|*)
    show_help
    ;;
esac

#docker stop
docker stop $docker_name
