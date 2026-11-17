"""Exercise the real BotSpawnIndex lookups against a stubbed map store (no game/database needed)."""
from pathlib import Path
import shutil
import subprocess
import tempfile

source = (Path(__file__).resolve().parents[1] / "src/BotSpawnIndex.cpp").read_text()
start = source.index("bool BotSpawnIndex::HasSpawn(")
end = source.index("std::vector<uint32> const& BotSpawnIndex::Lookup(")
lookups = source[start:end]
harness = r'''
#include <algorithm>
#include <cassert>
#include <cstdint>
#include <vector>
using uint32=uint32_t;
struct BotSpawn { uint32 mapId=0; float x=0, y=0, z=0; };
struct MapEntry { bool instance; bool Instanceable() const { return instance; } };
struct MapStore {
 // Map 33 is a dungeon, everything else is open world; map 999 does not exist.
 MapEntry open{false}, dungeon{true};
 MapEntry const* LookupEntry(uint32 id) const { return id==999 ? nullptr : (id==33 ? &dungeon : &open); }
} sMapStore;
struct BotSpawnIndex {
 struct Row { uint32 entry; BotSpawn spawn; };
 typedef std::vector<Row> RowVec;
 RowVec _creatures, _gameobjects;
 bool HasSpawn(uint32 entry, bool gameobject) const;
 bool FindNearest(uint32 entry, bool gameobject, uint32 mapId, float x, float y, float z,
     bool sameMapOnly, BotSpawn& out) const;
};
'''
harness += lookups + r'''
int main() {
 BotSpawnIndex index;
 // Sorted by entry, as Load() leaves them.
 index._creatures = {
  {10, {0, 100, 0, 0}}, {10, {0, 10, 0, 0}}, {10, {1, 1, 0, 0}},
  {20, {33, 5, 5, 5}}, {20, {530, 7, 7, 7}}, {20, {999, 9, 9, 9}},
  {30, {33, 1, 2, 3}},
 };
 index._gameobjects = { {10, {571, 4, 4, 4}} };
 BotSpawn out;

 assert(index.HasSpawn(10, false) && index.HasSpawn(30, false) && index.HasSpawn(10, true));
 assert(!index.HasSpawn(11, false) && !index.HasSpawn(20, true) && !index.HasSpawn(99, false));

 // Same map: the nearest spawn wins, even when another map is listed first or last.
 assert(index.FindNearest(10, false, 0, 0, 0, 0, false, out) && out.mapId == 0 && out.x == 10);
 assert(index.FindNearest(10, false, 0, 90, 0, 0, true, out) && out.x == 100);
 assert(index.FindNearest(10, false, 1, 50, 0, 0, true, out) && out.mapId == 1);

 // No spawn on this map: nothing with sameMapOnly, otherwise an open-world map before a dungeon.
 assert(!index.FindNearest(20, false, 0, 0, 0, 0, true, out));
 assert(index.FindNearest(20, false, 0, 0, 0, 0, false, out) && out.mapId == 530);
 assert(index.FindNearest(30, false, 0, 0, 0, 0, false, out) && out.mapId == 33);

 // Creatures and gameobjects are separate tables.
 assert(index.FindNearest(10, true, 0, 0, 0, 0, false, out) && out.mapId == 571);
 assert(!index.FindNearest(99, false, 0, 0, 0, 0, false, out));
}
'''
compiler = shutil.which("g++") or shutil.which("clang++")
if not compiler:
    raise SystemExit("A C++ compiler (g++ or clang++) is required")
with tempfile.TemporaryDirectory(prefix="playerbot-spawns-") as directory:
    root = Path(directory)
    cpp = root / "spawns.cpp"
    binary = root / "spawns.exe"
    cpp.write_text(harness)
    subprocess.run([compiler, "-std=c++17", str(cpp), "-o", str(binary)], check=True)
    subprocess.run([str(binary)], check=True)
print("PASS: spawn lookups prefer the same map, then the open world, and keep creatures and objects apart")
