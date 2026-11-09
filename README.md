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

The examples install everything under `~/skyfire`.

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
echo "$HOME/skyfire/deps/openssl/lib64" | sudo tee /etc/ld.so.conf.d/skyfire-openssl.conf
sudo ldconfig
```

### 4. Get the source and build
Clone the branch you want; the folder name and `PREFIX` keep each realm apart.
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
For the Stable realm use `-b Stable`, `~/skyfire/src-stable` and
`-DPREFIX=$HOME/skyfire/stable`.

The servers end up in `<PREFIX>/bin` and their configs in `<PREFIX>/etc`.
Modules in `modules/` (such as mod-qol) are built in automatically.

### 5. Client data
`-DTOOLS=ON` builds the extractors into `<PREFIX>/bin`. Run them from inside
your 5.4.8 client folder, in this order, then move the resulting `dbc`, `maps`,
`vmaps` and `mmaps` folders to `~/skyfire/data`:
```bash
cd /path/to/wow-5.4.8
~/skyfire/dev/bin/mapextractor
~/skyfire/dev/bin/vmap4extractor
mkdir -p vmaps && ~/skyfire/dev/bin/vmap4assembler Buildings vmaps
mkdir -p mmaps && ~/skyfire/dev/bin/mmaps_generator
```
Extract once; both realms share `~/skyfire/data`.

### 6. Databases and configuration
Follow [tools/realms/README.md](tools/realms/README.md). In short: create the
databases with `sql/create/create_mysql_realms.sql`, run
`tools/realms/configure_realm.sh` with `--auto-setup --world-dump <file>`,
start `authserver`, register the realms with `sql/create/realmlist_realms.sql`,
then start `worldserver`. The world database dump is published on the
[releases page](https://github.com/ProjectSkyfire/SkyFire_548/releases).

### 7. Run
```bash
cd ~/skyfire/stable/bin && ./authserver     # one authserver, from the Stable install
cd ~/skyfire/dev/bin    && ./worldserver    # one worldserver per realm
```
Use `tmux`/`screen`, or systemd units based on `<PREFIX>/etc/worldserverd.service.dist`.

### Updating
```bash
cd ~/skyfire/src-dev && git pull
cmake --build build --parallel "$(nproc)" && cmake --install build
tools/realms/configure_realm.sh dev --prefix ~/skyfire/dev --sql ~/skyfire/src-dev/sql
```
Then restart the worldserver; it applies new SQL updates on startup.

Changes go `Development` → test on the Development realm → pull request into
`Stable`. Back up the Stable databases before updating Stable.

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
