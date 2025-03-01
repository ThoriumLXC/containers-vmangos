#!/bin/sh
#
# Executes the build processes of vmangos, based on the
# build & source directories provided by the environment variables.
#
# All source files are prebaked within the container image.
#

cd "$SOURCE_DIR/sql/migrations"
chmod +x merge.sh
./merge.sh

dir_database="$BUILD_DIR/db"
dir_sql="$dir_database/sql"
dir_migrations="$dir_sql/migrations"

mkdir -p "$dir_migrations"
mv characters_db_updates.sql "$dir_migrations"
mv logon_db_updates.sql "$dir_migrations"
mv logs_db_updates.sql "$dir_migrations"
mv world_db_updates.sql "$dir_migrations"

cp "$SOURCE_DIR/sql"/*.sql "$dir_sql/"
cp "$DATABASE_DIR/world.sql" "$dir_sql/world.sql"

cp -r /docker-entrypoint-initdb.d "$dir_database/"
chmod +x "/docker-entrypoint-initdb.d"/*.sh

cp -r /always-initdb.d "$dir_database/"
chmod +x "/always-initdb.d"/*.sh
