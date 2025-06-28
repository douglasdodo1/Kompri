#!/bin/bash
set -e

echo "Aguardando o banco de dados iniciar..."

until pg_isready -h db -p 5432 -U $POSTGRES_USER; do
  sleep 1
done

echo "Banco de dados disponível!"

bundle exec rails db:prepare

exec "$@"
