#
# This file is part of Project SkyFire https://www.projectskyfire.org. 
# See COPYRIGHT file for Copyright information
#

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  Events/brewfest.cpp
  Events/childrens_week.cpp
  Events/hallows_end.cpp
  Events/holiday_events_tc.cpp
  Events/midsummer_fire_festival.cpp
  Events/pilgrims_bounty.cpp
  Events/winter_veil.cpp
)

include(Events/darkmoonfaire/CMakeLists.txt)

message("  -> Prepared: Events")
