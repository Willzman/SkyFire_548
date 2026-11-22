/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

#ifndef _MODELIGNOREFLAGS_H_
#define _MODELIGNOREFLAGS_H_

#include "Define.h"

namespace VMAP
{
    // Static vmap models a line of sight check may look through.
    // Ported from TrinityCore 01d715eaef (Core/Vmaps: Stop M2s from occluding for spellcast LoS, GPL v2).
    enum class ModelIgnoreFlags : uint32
    {
        Nothing = 0x00,
        M2      = 0x01  // doodads (trees, bushes, ferns, rocks); WMOs (buildings, caves) still block
    };

    inline ModelIgnoreFlags operator&(ModelIgnoreFlags left, ModelIgnoreFlags right) { return ModelIgnoreFlags(uint32(left) & uint32(right)); }
    inline ModelIgnoreFlags operator|(ModelIgnoreFlags left, ModelIgnoreFlags right) { return ModelIgnoreFlags(uint32(left) | uint32(right)); }
}

#endif // _MODELIGNOREFLAGS_H_
