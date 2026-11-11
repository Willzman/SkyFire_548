<p align="center">
  <img src="contrib/skyfire_transp.png" alt="Project SkyFire logo" width="520">
</p>

## Build Status
[![ubuntu-build](https://github.com/Willzman/SkyFire_548/actions/workflows/ubuntu.yml/badge.svg?branch=Development)](https://github.com/Willzman/SkyFire_548/actions/workflows/ubuntu.yml)
[![CodeFactor](https://www.codefactor.io/repository/github/projectskyfire/skyfire_548/badge)](https://www.codefactor.io/repository/github/projectskyfire/skyfire_548)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/57a11392c3ed42dcae439669e893565f)](https://app.codacy.com/gh/ProjectSkyfire/SkyFire_548/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)

## Project Information
SkyFire is a *MMORPG* Framework based mostly on C++.

SkyFireEMU is a MMORPG Framework based mostly on C++. It is completely 
open-source, and is community supported. It is derived
from CactusEmu, TrinityCore, and MaNGOS, the Massive Network Game Object Servers, 
and is based on the code of their projects with extensive changes over time to optimize, 
improve and cleanup the code base at the same time as improving the in game mechanics
and functionality.

It is completely open source; community involvement is highly encouraged.

If you wish to contribute ideas or code please visit our site linked below or
make pull requests to our 
[Github repository](https://github.com/ProjectSkyfire/SkyFire_548/pulls).

For further information on the SkyFire project, please visit our project website at 
[projectskyfire.org](http://www.projectskyfire.org).

## Supported Client Version
**MoP 5.4.8 Build 18414**

## Roadmap / TODO
Goal of this fork: as complete and class-accurate a MoP 5.4.8 server as possible. Most fixes are ported
from [Legends of Azeroth Pandaria](https://github.com/Legends-of-Azeroth/Legends-of-Azeroth-Pandaria-5.4.8)
(GPL v2+); older content can come from AzerothCore and TrinityCore (GPL v2+). One pull request per item.
Everything marked done is merged into `Development` and **still needs in-game testing**.

**Done**
- [x] Script API compatibility for ported scripts (#9, #12)
- [x] Scripts the world DB already expected: Gate of the Setting Sun, Mogu'shan Vaults, Mogu'shan Palace,
  Temple of the Jade Serpent, Shado-Pan Monastery, Zul'Gurub, Zul'Aman (re-enabled), Wandering Isle,
  Emerald Dragons and more, with their missing spawns and DB rows (#10, #13–#17, #22–#24); dead ScriptName
  bindings cleaned up (#25, #26)
- [x] Missing quest starters/enders (#20), item and trinket spell scripts (#21), creature loot (#19)
- [x] Class accuracy: MoP spell-power coefficients from the client data (#27), GCD haste rules (#28),
  Warlock resource regen (#29), missing class aura types such as spell power %, rating %, auto-attack %
  and mana regen (#30)
- [x] Class accuracy, second pass: class spell DB rows and glyph-learned spells (#33), absorbs scaling with
  spell power (#34), custom spell attributes (#35), energy/focus regen with haste and pet stat auras (#36),
  real PPM procs for 5.4 trinkets, enchants and tier bonuses (#37), class spell corrections (#38),
  Vengeance for all tanks (#41), Shaman, Priest and Mage script gaps (#39, #40, #43), power-level auras (#42)

**Class accuracy (priority)**
- [ ] In-game testing of all class fixes
- [ ] Remaining class gaps: Shaman T16 Restoration 4P, Prayer of Mending (Divine Insight), absorbs and the
  "ignore PvP power" flag, a few class spell corrections that need their LoA scripts

**MoP content**
- [ ] Remaining 5-man dungeons: Stormstout Brewery, Siege of Niuzao Temple, Gate of the Setting Sun trash
- [ ] Isle of Thunder (spawns, quests, Nalak) and Pandaria zone scripting
- [ ] Scarlet Halls, Scarlet Monastery and Scholomance (MoP versions)
- [ ] Scenario framework, then the scenarios
- [ ] Raids: Heart of Fear, Terrace of Endless Spring, Throne of Thunder, Siege of Orgrimmar
- [ ] World bosses and Timeless Isle; challenge modes; MoP battlegrounds and arenas

**Other gaps**
- [ ] Cataclysm instances and zones; selected older instances (AzerothCore for Outland/Northrend)
- [ ] Quests with no giver in any source, unscripted elites and rares, missing loot
- [ ] Pet battle ability effects; DB fill-ins (vendors, item and gameobject templates)

## Requirements
+ Ubuntu 24.04 LTS, x86_64, with a processor that supports SSE2.
+ GCC 14 (`g++-14`; C++23).
+ CMake 3.27.7 or newer (Ubuntu 24.04 ships 3.28) and Ninja.
+ Boost 1.91.0 and OpenSSL 4.0 with the legacy provider. Ubuntu's packages are
  too old, so both are built from source below.
+ MySQL server and client development libraries (`default-libmysqlclient-dev`).
+ The World of Warcraft 5.4.8 (build 18414) client, to extract maps and DBC data.

## Install (Ubuntu 24.04)
These steps build one server. To run the Stable and Development realms side by
side, build each branch into its own folder (step 4) and then follow
[tools/realms/README.md](tools/realms/README.md) for the databases and
configuration.

The examples put everything under `~/skyfire`. Each realm has **two** folders,
and the commands below always use the right one:

```
~/skyfire/
  src-dev/       Development source code (git clone): build here, run tools/realms/ and sql/ from here
  src-stable/    Stable source code (git clone)
  dev/           Development server, installed by the build: bin/ (programs) and etc/ (configs)
  stable/        Stable server, installed by the build: bin/ and etc/
  data/          client data (dbc, db2, cameras, maps, vmaps, mmaps), shared by both realms
  deps/          Boost and OpenSSL, shared by both realms
```
`src-…` folders are what you **build and update**; `dev`/`stable` are what you
**run**. Don't create `dev`/`stable` yourself; `cmake --install` does that.

Only want the Development realm for now? Follow the steps below with the
changes in [Development only](#development-only-no-stable-yet); you can add
Stable later without redoing anything.

### 1. Packages
```bash
sudo apt-get update
sudo apt-get install -y build-essential gcc-14 g++-14 cmake ninja-build ccache git \
  pkg-config wget perl libbz2-dev libreadline-dev zlib1g-dev \
  default-libmysqlclient-dev mysql-server
```

### 2. Boost 1.91.0
```bash
mkdir -p ~/skyfire/deps && cd /tmp
wget https://archives.boost.io/release/1.91.0/source/boost_1_91_0.tar.gz
tar -xzf boost_1_91_0.tar.gz && cd boost_1_91_0
./bootstrap.sh
./b2 install --prefix=$HOME/skyfire/deps/boost --with-headers -j"$(nproc)"
```

### 3. OpenSSL 4.0
```bash
cd /tmp
wget https://www.openssl.org/source/openssl-4.0.0.tar.gz
tar -xzf openssl-4.0.0.tar.gz && cd openssl-4.0.0
./Configure linux-x86_64 --prefix=$HOME/skyfire/deps/openssl \
  --openssldir=$HOME/skyfire/deps/openssl/ssl shared enable-legacy
make -j"$(nproc)" && make install_sw install_ssldirs
# Let the servers find these libraries at runtime:
printf '%s\n' "$HOME/skyfire/deps/openssl/lib64" "$HOME/skyfire/deps/openssl/lib" \
  | sudo tee /etc/ld.so.conf.d/skyfire-openssl.conf
sudo ldconfig
```

### 4. Get the source and build
Each realm gets its own clone and install folder (`PREFIX`), so build both.

**Development realm:**
```bash
git clone -b Development https://github.com/Willzman/SkyFire_548 ~/skyfire/src-dev
cd ~/skyfire/src-dev
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER=gcc-14 -DCMAKE_CXX_COMPILER=g++-14 \
  -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
  -DPREFIX=$HOME/skyfire/dev -DTOOLS=ON -DUSE_COREPCH=ON -DUSE_SCRIPTPCH=ON \
  -DBOOST_ROOT=$HOME/skyfire/deps/boost -DOPENSSL_ROOT_DIR=$HOME/skyfire/deps/openssl
cmake --build build --parallel "$(nproc)"
cmake --install build
```

**Stable realm:** the `Stable` branch only has these setup tools once
`Development` has been merged into it (pull request `Development` → `Stable`).
Do that before the very first Stable build.
```bash
git clone -b Stable https://github.com/Willzman/SkyFire_548 ~/skyfire/src-stable
cd ~/skyfire/src-stable
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER=gcc-14 -DCMAKE_CXX_COMPILER=g++-14 \
  -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
  -DPREFIX=$HOME/skyfire/stable -DTOOLS=ON -DUSE_COREPCH=ON -DUSE_SCRIPTPCH=ON \
  -DBOOST_ROOT=$HOME/skyfire/deps/boost -DOPENSSL_ROOT_DIR=$HOME/skyfire/deps/openssl
cmake --build build --parallel "$(nproc)"
cmake --install build
```

The programs end up in `~/skyfire/dev/bin` and `~/skyfire/stable/bin`, and
their config files in `~/skyfire/dev/etc` and `~/skyfire/stable/etc`.
Modules in `modules/` (such as mod-qol) are built in automatically.

### 5. Client data
`-DTOOLS=ON` builds the extractors into `~/skyfire/dev/bin` (and
`~/skyfire/stable/bin`; either copy works). Run them from inside
your 5.4.8 client folder (the one containing `Data/`), in this order, then move
the resulting folders to `~/skyfire/data`:
```bash
mkdir -p ~/skyfire/data
cd /path/to/wow-5.4.8
~/skyfire/dev/bin/mapextractor
~/skyfire/dev/bin/vmap4extractor
mkdir -p vmaps && ~/skyfire/dev/bin/vmap4assembler Buildings vmaps
mkdir -p mmaps && ~/skyfire/dev/bin/mmaps_generator
```
```bash
mv dbc db2 cameras maps vmaps mmaps ~/skyfire/data/
```
Extract once; both realms share `~/skyfire/data`.

### 6. Databases, configuration and first start (one time)
You only do this once. Each server creates and fills its own databases the
first time it starts; you just create the MySQL user, point each realm at the
world data, and start things in the right order.

Both realms share one `auth` database (accounts and the realm list). Each realm
has its own world and characters databases:

| Realm       | World database | Characters database | Port |
|-------------|----------------|---------------------|------|
| Stable      | `world_stable` | `characters_stable` | 8085 |
| Development | `world_dev`    | `characters_dev`    | 8086 |

**6.1 Create the MySQL user and the empty databases.** This uses the MySQL root
account and is the only step that needs it:
```bash
sudo mysql < ~/skyfire/src-dev/sql/create/create_mysql_realms.sql
```
This creates the five databases above and a MySQL user `skyfire` (password
`skyfire`) that can use them.

**6.2 Download the world database.** Get the world database `.sql` file from the
[releases page](https://github.com/ProjectSkyfire/SkyFire_548/releases), unzip
it, and save it as `~/skyfire/world_database.sql`. Both realms load from the
same file.

**6.3 Configure each realm.** Run both commands. They create each realm's config
files and fill in its database names, ports and paths:
```bash
cd ~/skyfire/src-dev
tools/realms/configure_realm.sh dev --prefix ~/skyfire/dev \
  --sql ~/skyfire/src-dev/sql --data ~/skyfire/data \
  --auto-setup --world-dump ~/skyfire/world_database.sql

cd ~/skyfire/src-stable
tools/realms/configure_realm.sh stable --prefix ~/skyfire/stable \
  --sql ~/skyfire/src-stable/sql --data ~/skyfire/data \
  --auto-setup --world-dump ~/skyfire/world_database.sql
```
If the script says the dump "switches database", run the `sed` command it
prints and then run it again.

**6.4 Start the authserver** (terminal 1) and leave it running:
```bash
cd ~/skyfire/stable/bin && ./authserver
```
On this first start it fills the `auth` database.

**6.5 Add both realms to the realm list** (terminal 2), once the authserver is up:
```bash
mysql -u skyfire -pskyfire auth < ~/skyfire/src-dev/sql/create/realmlist_realms.sql
```

**6.6 Start both worldservers** (terminals 3 and 4) and leave them running:
```bash
cd ~/skyfire/stable/bin && ./worldserver
```
```bash
cd ~/skyfire/dev/bin && ./worldserver
```
The first start imports the world database and applies every update, which
can take several minutes. It is done when the log says `ready...` and you get
a `SF>` prompt.

**6.7 Create your account.** Type these at the `SF>` prompt of either
worldserver. Accounts are shared, so one account works on both realms:
```
account create you@example.com myname mypassword
account set gmlevel myname 3 -1
```
The second line makes the account a GM (level 3) on all realms (`-1`); leave
it out for a normal player account.

**6.8 Log in.** In your 5.4.8 client folder, edit `WTF/Config.wtf` so it
contains `SET realmlist "127.0.0.1"`. Log in with the email address and
password from 6.7, then choose **Stable** or **Development** from the realm
list.

*Game on a different computer than the server?* Use the server's LAN IP
(e.g. `192.168.1.50`) in `Config.wtf`, **and** tell the realm list that address,
otherwise the client finds the realms but cannot enter them. Then restart the
authserver:
```bash
mysql -u skyfire -pskyfire auth -e "UPDATE realmlist SET address='192.168.1.50' WHERE id IN (1,2);"
```
Open ports 3724 (login), 8085 (Stable) and 8086 (Development) in the server's
firewall if it has one (`sudo ufw allow 3724,8085,8086/tcp`).

*Client won't connect at all?* Some 5.4.8 clients must be patched to talk to a
private server; `contrib/Client_Patch` contains a patcher for the client's
`Wow.exe`/`Wow-64.exe` (it runs on Windows, where the game client lives).

### 7. Running it day to day
Start the authserver first, then the worldservers. Each in its own terminal
(or `tmux`/`screen`):
```bash
cd ~/skyfire/stable/bin && ./authserver    # only one authserver, from the Stable install
cd ~/skyfire/stable/bin && ./worldserver   # Stable realm
cd ~/skyfire/dev/bin    && ./worldserver   # Development realm
```
To start them automatically at boot, make systemd units from
`~/skyfire/dev/etc/worldserverd.service.dist` (same file in `stable/etc`).

### Development only (no Stable yet)
You can run just the Development realm and add Stable later. Normally the
login server (`authserver`) runs from the Stable install; without it, run it
from the Development install instead. Follow the steps above with these
changes:

| Step | Change |
|------|--------|
| 4    | Build only the **Development realm** block. |
| 6.3  | Run only the `dev` command, and add `--with-authserver` to it (see below). |
| 6.4  | Start the authserver from the dev install: `cd ~/skyfire/dev/bin && ./authserver` |
| 6.6  | Start only the Development worldserver. |
| 6.8  | Pick **Development** in the realm list. **Stable** is listed too but shows offline until you install it. |

Step 6.3 for Development only:
```bash
cd ~/skyfire/src-dev
tools/realms/configure_realm.sh dev --prefix ~/skyfire/dev \
  --sql ~/skyfire/src-dev/sql --data ~/skyfire/data \
  --auto-setup --world-dump ~/skyfire/world_database.sql --with-authserver
```
Everything else (6.1, 6.2, 6.5, 6.7) is unchanged. 6.1 also creates the empty
`world_stable` and `characters_stable` databases; they wait unused.

**Adding Stable later:**
1. Merge `Development` into `Stable` (pull request `Development` → `Stable`).
2. Build the **Stable realm** block from step 4 and run the `stable` command from
   step 6.3.
3. Stop the authserver running from `~/skyfire/dev/bin` and start it from
   `~/skyfire/stable/bin` instead. Only one authserver can run (both use
   port 3724).
4. Start the Stable worldserver.

Accounts and characters you made on Development stay; both realms use the same
`auth` database.

### Updating
**Development realm** (any time):
```bash
cd ~/skyfire/src-dev && git pull
cmake --build build --parallel "$(nproc)" && cmake --install build
tools/realms/configure_realm.sh dev --prefix ~/skyfire/dev --sql ~/skyfire/src-dev/sql
```
Then restart the Development worldserver; it applies new SQL updates on startup.

**Stable realm** (after the changes are merged into `Stable`):
```bash
sudo mysqldump --databases auth world_stable characters_stable \
  > ~/skyfire/backup-stable-$(date +%F).sql
cd ~/skyfire/src-stable && git pull
cmake --build build --parallel "$(nproc)" && cmake --install build
tools/realms/configure_realm.sh stable --prefix ~/skyfire/stable --sql ~/skyfire/src-stable/sql
```
Then restart the authserver and the Stable worldserver.

Changes go `Development` → test on the Development realm → pull request into
`Stable`.

Upstream wiki guide: [Ubuntu 24.04](https://wiki.projectskyfire.org/index.php?title=Installation_(Ubuntu_24.04_LTS)).

## Reporting issues
Please use the search function before you report issues.
[SkyFire Issue Tracker](https://github.com/ProjectSkyfire/SkyFire_548/issues).

## Submitting fixes
Fixes are submitted as pull requests.

[SkyFire Pull Request](https://github.com/ProjectSkyfire/SkyFire_548/pulls)

## Copyright
License: GPL 3.0

Read file [LICENSE](LICENSE.md)

## Authors &amp; Contributors
Read file [THANKS](THANKS.md)

## Links
Forum: [https://www.projectskyfire.org/](https://www.projectskyfire.org/)

Database Releases: [https://github.com/ProjectSkyfire/SkyFire_548/releases](https://github.com/ProjectSkyfire/SkyFire_548/releases)

Wiki: [https://wiki.projectskyfire.org](https://wiki.projectskyfire.org)
