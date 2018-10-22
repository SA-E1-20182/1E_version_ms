while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 5
done

# Create, migrate, and seed database if it doesn't exist.

mix ecto.create
mix ecto.migrate

if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
  echo "Database $PGDATABASE does not exist. Creating..."
  createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T versioning
  mix ecto.create
  mix ecto.migrate
  echo "Database $PGDATABASE created."
fi

exec mix phoenix.server
