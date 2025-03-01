#!/bin/bash

echo "[mariadb]: Creating databases"
SQL_COMMAND=$(cat <<-EOF
CREATE DATABASE IF NOT EXISTS mangos DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS characters DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS realmd DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS logs DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
EOF
)
mariadb -u root -p"$MARIADB_ROOT_PASSWORD" -e "$SQL_COMMAND"

echo "[mariadb]: Granting permissions"
SQL_COMMAND=$(cat <<EOF
GRANT ALL ON mangos.* TO '$MARIADB_USER'@'%';
GRANT ALL ON characters.* TO '$MARIADB_USER'@'%';
GRANT ALL ON realmd.* TO '$MARIADB_USER'@'%';
GRANT ALL ON logs.* TO '$MARIADB_USER'@'%';
FLUSH PRIVILEGES;
EOF
)
mariadb -u root -p"$MARIADB_ROOT_PASSWORD" -e "$SQL_COMMAND"

echo "[mariadb]: Running world.sql"
mariadb -u root -p$MARIADB_ROOT_PASSWORD mangos < /sql/world.sql

echo "[mariadb]: Running characters.sql"
mariadb -u root -p$MARIADB_ROOT_PASSWORD characters < /sql/characters.sql

echo "[mariadb]: Running logon.sql"
mariadb -u root -p$MARIADB_ROOT_PASSWORD realmd < /sql/logon.sql

echo "[mariadb]: Running logs.sql"
mariadb -u root -p$MARIADB_ROOT_PASSWORD logs < /sql/logs.sql

if [ -e /sql/migrations/world_db_updates.sql ]; then
  echo "[mariadb]: Executing world_db_updates.sql"
  mariadb -u root -p"$MARIADB_ROOT_PASSWORD" mangos < /sql/migrations/world_db_updates.sql
fi

if [ -e /sql/migrations/characters_db_updates.sql ]; then
  echo "[mariadb]: Executing characters_db_updates.sql"
  mariadb -u root -p"$MARIADB_ROOT_PASSWORD" characters < /sql/migrations/characters_db_updates.sql
fi

if [ -e /sql/migrations/logon_db_updates.sql ]; then
  echo "[mariadb]: Executing logon_db_updates.sql"
  mariadb -u root -p"$MARIADB_ROOT_PASSWORD" realmd < /sql/migrations/logon_db_updates.sql
fi

if [ -e /sql/migrations/logs_db_updates.sql ]; then
  echo "[mariadb]: Executing logs_db_updates.sql"
  mariadb -u root -p"$MARIADB_ROOT_PASSWORD" logs < /sql/migrations/logs_db_updates.sql
fi

echo "[mariadb]: Configuring default realm"
SQL_COMMAND=$(cat <<EOF
INSERT INTO realmd.realmlist (name, address, port, icon, timezone, allowedSecurityLevel)
VALUES ('$REALMLIST_NAME', '$REALMLIST_ADDRESS', '$REALMLIST_PORT', '$REALMLIST_ICON', '$REALMLIST_TIMEZONE', '$REALMLIST_ALLOWED_SECURITY_LEVEL');
EOF
)
mariadb -u root -p"$MARIADB_ROOT_PASSWORD" -e "$SQL_COMMAND"

echo "[mariadb]: Running user accounts.sql"
mariadb -u root -p$MARIADB_ROOT_PASSWORD realmd < /sql/user_accounts.sql

echo "[mariadb]: $0 completed"
