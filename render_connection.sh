#Allows to login to the render postgres database 


#!/usr/bin/env bash

# --- Load .env securely ---
if [[ -f .env ]]; then
  # shellcheck disable=SC1091
  source .env
  RENDER_DB_HOST=$(echo $RENDER_DB_HOST | tr -d '\r')
  RENDER_DB_PASS=$(echo $RENDER_DB_PASS | tr -d '\r')
  RENDER_DB_USER=$(echo $RENDER_DB_USER | tr -d '\r')
  RENDER_DB_NAME=$(echo $RENDER_DB_NAME | tr -d '\r')
  RENDER_DB_PORT=$(echo $RENDER_DB_PORT | tr -d '\r')
else
  echo "❌ Missing .env file. Aborting."
  exit 1
fi

show_help() {
  cat <<EOF
Usage: $0 [command]
Commands:
    create         Create 'users' table (id, username,email,password) if not exists
    select         Select all rows from users table
    add            Insert example users (Alice, Bob, Camille)
    clean          Delete all users
    login          Open psql shell
    help           Show this help
EOF
}

run_psql() {
  PGPASSWORD=${RENDER_DB_PASS} psql \
    -h "${RENDER_DB_HOST}" \
    -U "${RENDER_DB_USER}" \
    -d "${RENDER_DB_NAME}" \
    -p "${RENDER_DB_PORT}" \
    -c "$1"
}

case "$1" in
  create)
    run_psql "CREATE TABLE IF NOT EXISTS users (
      id SERIAL PRIMARY KEY,
      username VARCHAR(50),
      email VARCHAR(100),
      password VARCHAR(100)
    );"
    ;;
  select)
    run_psql "SELECT * FROM users;"
    ;;
  add)
    run_psql "INSERT INTO users (username, email, password) VALUES 
      ('Alice', 'alice@example.com', '1111'),
      ('Bob', 'Bob@example.com', '2222'),
      ('Camille', 'Camille@example.com', '3333');"
    ;;
  clean)
    run_psql "DELETE FROM users;"
    ;;
  login)
    # Open a psql shell to the online DB
    PGPASSWORD=${RENDER_DB_PASS} psql \
      -h "${RENDER_DB_HOST}" \
      -U "${RENDER_DB_USER}" \
      -d "${RENDER_DB_NAME}" \
      -p "${RENDER_DB_PORT}"
    ;;
  help|*)
    show_help
    ;;
esac
