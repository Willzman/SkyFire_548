# Running Stable and Development realms on one machine

Both realms share one MySQL server, one `auth` database (accounts and the realm
list) and one authserver. Each realm has its own world and characters
databases, its own source checkout and its own install folder.

| Realm       | Branch        | RealmID | Port | World DB       | Characters DB       | Pending SQL |
|-------------|---------------|---------|------|----------------|---------------------|-------------|
| Stable      | `Stable`      | 1       | 8085 | `world_stable` | `characters_stable` | off         |
| Development | `Development` | 2       | 8086 | `world_dev`    | `characters_dev`    | on          |

## One-time setup

1. Clone and build each branch into its own prefix, e.g. `~/skyfire/src-stable`
   installed with `-DPREFIX=$HOME/skyfire/stable`, and `~/skyfire/src-dev`
   with `-DPREFIX=$HOME/skyfire/dev`.

2. Create the databases and the `skyfire` MySQL user:

       mysql -u root -p < sql/create/create_mysql_realms.sql

3. Import the base data:

       mysql -u root -p auth              < sql/base/auth_database.sql
       mysql -u root -p characters_stable < sql/base/characters_database.sql
       mysql -u root -p characters_dev    < sql/base/characters_database.sql

   Import the world base dump (not stored in Git) into both `world_stable`
   and `world_dev`, then `sql/base/stored_procs.sql` into each world database.

4. Register both realms in the shared realm list:

       mysql -u root -p auth < sql/create/realmlist_realms.sql

5. Configure each install. Re-run this after every install; it only sets the
   realm-specific keys and keeps your other edits:

       tools/realms/configure_realm.sh stable --prefix ~/skyfire/stable \
           --sql ~/skyfire/src-stable/sql --data ~/skyfire/data
       tools/realms/configure_realm.sh dev    --prefix ~/skyfire/dev \
           --sql ~/skyfire/src-dev/sql    --data ~/skyfire/data

   Pass `--db-user` / `--db-pass` if you changed the MySQL password.

6. Run `authserver` from the Stable install only, plus both worldservers.

## Notes

* Each worldserver applies new SQL from its own checkout's `sql/updates` at
  startup. Development also imports `sql/pending_updates`.
* The shared auth database is upgraded by the Stable authserver. Development
  code that needs a newer auth schema only works once that change reaches
  `Stable`.
* Different RA (3443/3444) and SOAP (7878/7879) ports are set so both realms
  can enable them without clashing.
