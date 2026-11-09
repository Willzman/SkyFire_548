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

2. Create the databases and the `skyfire` MySQL user (needs MySQL's root
   account, which on Ubuntu you reach with `sudo`; once):

       sudo mysql < sql/create/create_mysql_realms.sql

3. Get the world base dump (it is not stored in Git) as an uncompressed
   `.sql` file, e.g. `~/skyfire/world_database.sql`.

4. Configure each install with auto-setup. Re-run this after every install;
   it only sets the realm-specific keys and keeps your other edits:

       tools/realms/configure_realm.sh stable --prefix ~/skyfire/stable \
           --sql ~/skyfire/src-stable/sql --data ~/skyfire/data \
           --auto-setup --world-dump ~/skyfire/world_database.sql
       tools/realms/configure_realm.sh dev    --prefix ~/skyfire/dev \
           --sql ~/skyfire/src-dev/sql    --data ~/skyfire/data \
           --auto-setup --world-dump ~/skyfire/world_database.sql

   Pass `--db-user` / `--db-pass` if you changed the MySQL password. The
   script refuses a dump that contains `USE` or `CREATE DATABASE` lines (as
   `mysqldump --databases` writes) and prints the command that removes them;
   those lines would load the dump into `world` instead of this realm's
   database.

5. Start `authserver` from the Stable install. (Development without Stable: add
   `--with-authserver` to the `dev` command in step 4 and start `authserver`
   from the Development install instead.) On first start it fills the
   empty `auth` database and applies all auth updates.

6. Register both realms in the shared realm list (the servers do not add
   realms themselves):

       mysql -u skyfire -pskyfire auth < sql/create/realmlist_realms.sql

7. Start both worldservers. On first start each one imports the base SQL into
   its empty world and characters databases (the world dump plus
   `sql/base/stored_procs.sql`, and `sql/base/characters_database.sql`), then
   applies every update. Later starts skip the base import and only apply new
   updates. The world import takes a while; watch the log.

Leaving auto-setup on is safe: databases that already have tables are never
re-imported. Turn it off with `--no-auto-setup` if you prefer.

### Importing by hand instead

Do not import `characters_database.sql` or the world dump by hand and then
start the servers with `SqlPath` set: those files carry no update-tracking
table, so the server stops with "update tracking table is missing on a
non-empty schema". Let auto-setup import into empty databases, as above. If you
already imported by hand, empty the database and let auto-setup redo it. Only
set `WorldDatabase.AutoBaseline` / `CharacterDatabase.AutoBaseline` if you are
sure the imported data already contains every file in `sql/updates`; it marks
them all as applied without running them.

## Notes

* Each worldserver applies new SQL from its own checkout's `sql/updates` at
  startup. Development also imports `sql/pending_updates`.
* The shared auth database is upgraded by the Stable authserver. Development
  code that needs a newer auth schema only works once that change reaches
  `Stable`.
* Different RA (3443/3444) and SOAP (7878/7879) ports are set so both realms
  can enable them without clashing.
