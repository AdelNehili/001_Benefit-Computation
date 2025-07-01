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
    docker run --name benefits-db \
      -e POSTGRES_USER=benefits_user \
      -e POSTGRES_PASSWORD=benefits_pass \
      -e POSTGRES_DB=benefits_db \
      -p 5432:5432 \
      -d postgres
    ;;
  start)
    docker start $docker_name
    docker ps -a
    ;;
  query_select)
    docker start $docker_name
    docker exec -it $docker_name psql -U $db_user -d $db_name -c "SELECT * FROM users;"
    ;;
  query_add)
    docker start $docker_name
    docker exec -it $docker_name psql -U $db_user -d $db_name \
      -c "CREATE TABLE IF NOT EXISTS users (
             id SERIAL PRIMARY KEY,
             username VARCHAR(50),
             email VARCHAR(100),
             password VARCHAR(100)
         );" \
      -c "INSERT INTO users (username, email, password) VALUES ('Alice', 'alice@example.com', 1111);" \
      -c "INSERT INTO users (username, email, password) VALUES ('Bob', 'Bob@example.com', 2222);" \
      -c "INSERT INTO users (username, email, password) VALUES ('Camille', 'Camille@example.com', 3333);" 
    ;;
  clean_db)
    docker exec -it $docker_name psql -U $db_user -d $db_name \
      "DELETE FROM users;"
    ;;
  
  stop)
    docker stop $docker_name
    ;;
  rm)
    docker rm $docker_name
    ;;
  
  help|*)
    show_help
    ;;
esac

