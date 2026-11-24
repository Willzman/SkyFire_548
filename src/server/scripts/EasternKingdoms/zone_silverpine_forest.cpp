/*
* This file is part of Project SkyFire https://www.projectskyfire.org. 
* See LICENSE.md file for Copyright information
*/

/* ScriptData
SDName: Silverpine_Forest
SD%Complete: 100
SDComment: Quest support: 435, 26965 (The Warchief Cometh, from TrinityCore cata_classic)
SDCategory: Silverpine Forest
EndScriptData */

/* ContentData
npc_deathstalker_erland
npc_silverpine_grand_executor_mortuus
npc_silverpine_fallen_human
spell_silverpine_raise_forsaken_83173
spell_silverpine_forsaken_trooper_masterscript_high_command
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Player.h"
#include "ObjectAccessor.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"

/*######
## npc_deathstalker_erland
######*/

enum eErland
{
    SAY_QUESTACCEPT     = 0,
    SAY_START           = 1,
    SAY_AGGRO           = 2,
    SAY_PROGRESS        = 3,
    SAY_LAST            = 4,

    SAY_RANE            = 0,
    SAY_RANE_ANSWER     = 5,
    SAY_MOVE_QUINN      = 6,

    SAY_QUINN           = 7,
    SAY_QUINN_ANSWER    = 0,
    SAY_BYE             = 8,

    QUEST_ESCORTING     = 435,
    NPC_RANE            = 1950,
    NPC_QUINN           = 1951
};

class npc_deathstalker_erland : public CreatureScript
{
public:
    npc_deathstalker_erland() : CreatureScript("npc_deathstalker_erland") { }

    struct npc_deathstalker_erlandAI : public npc_escortAI
    {
        npc_deathstalker_erlandAI(Creature* creature) : npc_escortAI(creature) { }

        void WaypointReached(uint32 waypointId) OVERRIDE
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 1:
                    Talk(SAY_START, player);
                    break;
                case 10:
                    Talk(SAY_PROGRESS);
                    break;
                case 13:
                    Talk(SAY_LAST, player);
                    player->GroupEventHappens(QUEST_ESCORTING, me);
                    break;
                case 15:
                    if (Creature* rane = me->FindNearestCreature(NPC_RANE, 20.0f))
                        rane->AI()->Talk(SAY_RANE);
                    break;
                case 16:
                    Talk(SAY_RANE_ANSWER);
                    break;
                case 17:
                    Talk(SAY_MOVE_QUINN);
                    break;
                case 24:
                    Talk(SAY_QUINN);
                    break;
                case 25:
                    if (Creature* quinn = me->FindNearestCreature(NPC_QUINN, 20.0f))
                        quinn->AI()->Talk(SAY_QUINN_ANSWER);
                    break;
                case 26:
                    Talk(SAY_BYE);
                    break;
            }
        }

        void Reset() OVERRIDE { }

        void EnterCombat(Unit* who) OVERRIDE
        {
            Talk(SAY_AGGRO, who);
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) OVERRIDE
    {
        if (quest->GetQuestId() == QUEST_ESCORTING)
        {
            creature->AI()->Talk(SAY_QUESTACCEPT, player);

            if (npc_escortAI* pEscortAI = CAST_AI(npc_deathstalker_erland::npc_deathstalker_erlandAI, creature->AI()))
                pEscortAI->Start(true, false, player->GetGUID());
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_deathstalker_erlandAI(creature);
    }
};

/*######
## Quest 26965 "The Warchief Cometh" (Forsaken High Command)
## Ported from TrinityCore cata_classic zone_silverpine_forest.cpp (GPL v2).
######*/

namespace
{
    Position const OrgrimmarPortalPos[3] =
    {
        { 1358.62f, 1054.72f, 53.1200f, 0.0f },
        { 1393.27f, 1021.20f, 53.2225f, 0.0f },
        { 1404.71f, 1063.73f, 60.5617f, 0.0f }
    };

    Position const HellscreamElitePos[16] =
    {
        { 1387.90f, 1029.71f, 53.21853f, 2.827433f },
        { 1389.79f, 1024.51f, 53.20833f, 2.827433f },
        { 1388.05f, 1026.91f, 53.20833f, 2.827433f },
        { 1388.16f, 1020.88f, 53.25523f, 2.827433f },
        { 1385.79f, 1025.99f, 53.22593f, 2.827433f },
        { 1386.69f, 1023.26f, 53.24393f, 2.827433f },
        { 1384.33f, 1022.04f, 53.28123f, 2.827433f },
        { 1391.10f, 1027.73f, 53.20483f, 2.827433f },

        { 1359.10f, 1046.55f, 52.97053f, 5.253441f },
        { 1360.89f, 1051.81f, 53.19793f, 5.253441f },
        { 1360.75f, 1048.84f, 53.12893f, 5.253441f },
        { 1364.43f, 1053.62f, 53.29343f, 5.253441f },
        { 1363.08f, 1048.15f, 53.22223f, 5.253441f },
        { 1364.08f, 1050.84f, 53.29163f, 5.253441f },
        { 1366.69f, 1050.31f, 53.34203f, 5.253441f },
        { 1357.85f, 1050.12f, 52.99823f, 5.253441f }
    };

    Position const GarroshPos       = { 1402.45f, 1061.62f, 60.56173f, 3.926991f };
    Position const GarroshJumpPos   = { 1378.65f, 1044.23f, 53.8389f, 5.51524f };
    Position const CromushPos       = { 1404.71f, 1063.73f, 60.5617f, 2.827433f };
    Position const AgathaPreRisePos = { 1364.02f, 1028.54f, 66.99143f, 0.0f };
    Position const AgathaRisePos    = { 1368.65f, 1032.19f, 63.3033f, 0.0f };
    Position const AgathaPreResetPos = { 1364.02f, 1028.54f, 55.9914f, 0.855211f };
    Position const AgathaResetPos   = { 1364.02f, 1028.54f, 58.1319f, 0.7155f };

    enum QuestTheWarchiefCometh
    {
        QUEST_THE_WARCHIEF_COMETH               = 26965,

        NPC_LADY_SYLVANAS_WINDRUNNER_COMETH     = 44365,
        NPC_AGATHA_COMETH                       = 44608,
        NPC_PORTAL_FROM_ORGRIMMAR               = 44630,
        NPC_GARROSH_HELLSCREAM_COMETH           = 44629,
        NPC_HIGH_WARLORD_CROMUSH_COMETH         = 44640,
        NPC_HELLSCREAM_ELITE_COMETH             = 44636,

        SPELL_RAISE_FORSAKEN_COMETH             = 83173,
        SPELL_AIR_REVENANT_ENTRANCE             = 55761,
        SPELL_SIMPLE_TELEPORT                   = 12980,
        SPELL_WELCOME_TO_SILVERPINE_CREDIT      = 83384, // kill credit 44629, 30 yd around the caster

        EVENT_START_SCENE_COMETH                = 1,
        EVENT_SUMMON_PORTAL_COMETH              = 2,
        EVENT_SUMMON_GARROSH_COMETH             = 3,
        EVENT_AGATHA_RAISE_FORSAKEN             = 4,  // 4-8 are used
        EVENT_SCENE_TALK_COMETH                 = 9,  // 9-36 are used

        ACTION_START_SCENE_COMETH               = 1,

        // Sylvanas 0-10, Garrosh 0-8, Cromush 0-1 (creature_text groups)
        PATH_GARROSH_COMETH                     = 96940000, // walk off towards the portal
        PATH_CROMUSH_COMETH                     = 96940010, // run in from the portal

        POINT_AGATHA_PRE_RISE                   = 1,
        POINT_AGATHA_RISE                       = 2,
        POINT_AGATHA_PRE_RESET                  = 3,
        POINT_AGATHA_RESET                      = 4,

        ANIMKIT_GENERAL_1                       = 609,
        ANIMKIT_SYLV_1                          = 595,
        ANIMKIT_SYLV_2                          = 606,
        ANIMKIT_GARROSH_1                       = 662,
        ANIMKIT_GARROSH_2                       = 595
    };

    // 44615 - Grand Executor Mortuus
    struct npc_silverpine_grand_executor_mortuus : public ScriptedAI
    {
        npc_silverpine_grand_executor_mortuus(Creature* creature) : ScriptedAI(creature), _summons(me), _eventInProgress(false) { }

        void sQuestAccept(Player* /*player*/, Quest const* quest) OVERRIDE
        {
            if (quest->GetQuestId() == QUEST_THE_WARCHIEF_COMETH && !_eventInProgress)
                DoAction(ACTION_START_SCENE_COMETH);
        }

        void Reset() OVERRIDE
        {
            _events.Reset();
            _summons.DespawnAll();
            _garroshGUID = 0;
            _cromushGUID = 0;
            _sylvanasGUID = 0;
            _agathaGUID = 0;
            _eventInProgress = false;
        }

        void JustSummoned(Creature* summon) OVERRIDE
        {
            _summons.Summon(summon);

            switch (summon->GetEntry())
            {
                case NPC_GARROSH_HELLSCREAM_COMETH:
                    _garroshGUID = summon->GetGUID();
                    summon->CastSpell(summon, SPELL_SIMPLE_TELEPORT, false);
                    break;
                case NPC_HELLSCREAM_ELITE_COMETH:
                    summon->CastSpell(summon, SPELL_SIMPLE_TELEPORT, false);
                    break;
                case NPC_PORTAL_FROM_ORGRIMMAR:
                    summon->CastSpell(summon, SPELL_AIR_REVENANT_ENTRANCE, false);
                    break;
                case NPC_HIGH_WARLORD_CROMUSH_COMETH:
                    _cromushGUID = summon->GetGUID();
                    summon->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                    summon->GetMotionMaster()->MovePath(PATH_CROMUSH_COMETH, false);
                    break;
                default:
                    break;
            }
        }

        void DoAction(int32 action) OVERRIDE
        {
            if (action != ACTION_START_SCENE_COMETH)
                return;

            _eventInProgress = true;

            // Unlike TrinityCore the scene also runs (and gives the credit) when Sylvanas or Agatha is missing.
            if (Creature* sylvanas = me->FindNearestCreature(NPC_LADY_SYLVANAS_WINDRUNNER_COMETH, 100.0f))
                _sylvanasGUID = sylvanas->GetGUID();
            if (Creature* agatha = me->FindNearestCreature(NPC_AGATHA_COMETH, 100.0f))
                _agathaGUID = agatha->GetGUID();

            _events.ScheduleEvent(EVENT_START_SCENE_COMETH, 250);
        }

        Creature* Actor(uint64 guid) const { return guid ? ObjectAccessor::GetCreature(*me, guid) : NULL; }

        void Say(uint64 guid, uint8 group, float facing = -1.0f, uint32 animKit = 0)
        {
            Creature* actor = Actor(guid);
            if (!actor)
                return;

            if (facing >= 0.0f)
                actor->SetFacingTo(facing);
            if (animKit)
                actor->PlayOneShotAnimKit(animKit);
            if (actor->IsAIEnabled)
                actor->AI()->Talk(group);
        }

        void MoveAgatha(uint32 pointId, Position const& pos)
        {
            if (Creature* agatha = Actor(_agathaGUID))
                agatha->GetMotionMaster()->MovePoint(pointId, pos, false);
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                // Every step schedules the next one even when its actor is gone, so the scene always ends and resets.
                switch (eventId)
                {
                    case EVENT_START_SCENE_COMETH:
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH, 1000);
                        _events.ScheduleEvent(EVENT_SUMMON_PORTAL_COMETH, 4000);
                        _events.ScheduleEvent(EVENT_SUMMON_GARROSH_COMETH, 7500);
                        break;
                    case EVENT_SUMMON_PORTAL_COMETH:
                        for (Position const& pos : OrgrimmarPortalPos)
                            me->SummonCreature(NPC_PORTAL_FROM_ORGRIMMAR, pos, TempSummonType::TEMPSUMMON_TIMED_DESPAWN, 300000);
                        break;
                    case EVENT_SUMMON_GARROSH_COMETH:
                        for (Position const& pos : HellscreamElitePos)
                            me->SummonCreature(NPC_HELLSCREAM_ELITE_COMETH, pos, TempSummonType::TEMPSUMMON_TIMED_DESPAWN, 300000);
                        me->SummonCreature(NPC_GARROSH_HELLSCREAM_COMETH, GarroshPos, TempSummonType::TEMPSUMMON_TIMED_DESPAWN, 300000);
                        me->SummonCreature(NPC_HIGH_WARLORD_CROMUSH_COMETH, CromushPos, TempSummonType::TEMPSUMMON_TIMED_DESPAWN, 300000);
                        break;
                    case EVENT_SCENE_TALK_COMETH:
                        Say(_sylvanasGUID, 0); // Where is that ogre-headed buffoon?
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 1, 4500);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 1:
                        Say(_sylvanasGUID, 1, 0.808979f);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 2, 3500);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 2:
                        if (Creature* garrosh = Actor(_garroshGUID))
                            garrosh->GetMotionMaster()->MoveJump(GarroshJumpPos, 16.0f, 10.0f);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 3, 2500);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 3:
                        if (Creature* sylvanas = Actor(_sylvanasGUID))
                            sylvanas->SetFacingTo(3.924652f);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 4, 1000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 4:
                        if (Creature* garrosh = Actor(_garroshGUID))
                            if (Creature* sylvanas = Actor(_sylvanasGUID))
                                garrosh->SetFacingToObject(sylvanas);
                        Say(_garroshGUID, 0, -1.0f, ANIMKIT_GARROSH_1);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 5, 12000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 5:
                        Say(_garroshGUID, 1, 3.9444442f);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 6, 7000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 6:
                        Say(_sylvanasGUID, 2, 2.4260077f);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 7, 5000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 7:
                        Say(_sylvanasGUID, 3, 3.7350047f, ANIMKIT_SYLV_1);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 8, 16000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 8:
                        Say(_sylvanasGUID, 4);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 9, 4000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 9:
                        Say(_garroshGUID, 2);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 10, 3000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 10:
                        Say(_sylvanasGUID, 5);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 11, 6000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 11:
                        Say(_sylvanasGUID, 6);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 12, 6000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 12:
                        Say(_sylvanasGUID, 7, -1.0f, ANIMKIT_SYLV_2);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 13, 9000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 13:
                        Say(_sylvanasGUID, 8); // Agatha, show the Warchief!
                        _events.ScheduleEvent(EVENT_AGATHA_RAISE_FORSAKEN, 3000);
                        break;
                    case EVENT_AGATHA_RAISE_FORSAKEN:
                        MoveAgatha(POINT_AGATHA_PRE_RISE, AgathaPreRisePos);
                        _events.ScheduleEvent(EVENT_AGATHA_RAISE_FORSAKEN + 1, 2500);
                        break;
                    case EVENT_AGATHA_RAISE_FORSAKEN + 1:
                        if (Creature* agatha = Actor(_agathaGUID))
                            agatha->SetWalk(true);
                        MoveAgatha(POINT_AGATHA_RISE, AgathaRisePos);
                        _events.ScheduleEvent(EVENT_AGATHA_RAISE_FORSAKEN + 2, 6000);
                        break;
                    case EVENT_AGATHA_RAISE_FORSAKEN + 2:
                        if (Creature* agatha = Actor(_agathaGUID))
                            agatha->CastSpell(agatha, SPELL_RAISE_FORSAKEN_COMETH, false);
                        _events.ScheduleEvent(EVENT_AGATHA_RAISE_FORSAKEN + 3, 10000);
                        break;
                    case EVENT_AGATHA_RAISE_FORSAKEN + 3:
                        MoveAgatha(POINT_AGATHA_PRE_RESET, AgathaPreResetPos);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 14, 750);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 14:
                        Say(_cromushGUID, 0); // ABBERATION!
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 15, 3500);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 15:
                        Say(_garroshGUID, 3, -1.0f, ANIMKIT_GENERAL_1);
                        if (Creature* agatha = Actor(_agathaGUID))
                        {
                            // SkyFire's MovePoint has no final facing: turn her here.
                            agatha->SetFacingTo(AgathaPreResetPos.GetOrientation());
                            agatha->SetWalk(false);
                        }
                        _events.ScheduleEvent(EVENT_AGATHA_RAISE_FORSAKEN + 4, 12000);
                        break;
                    case EVENT_AGATHA_RAISE_FORSAKEN + 4:
                        MoveAgatha(POINT_AGATHA_RESET, AgathaResetPos);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 16, 1000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 16:
                        Say(_sylvanasGUID, 9, -1.0f, ANIMKIT_GENERAL_1);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 17, 10000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 17:
                        if (Creature* agatha = Actor(_agathaGUID))
                            agatha->SetFacingTo(AgathaResetPos.GetOrientation());
                        Say(_garroshGUID, 4);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 18, 6000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 18:
                        Say(_garroshGUID, 5);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 19, 6000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 19:
                        Say(_sylvanasGUID, 10); // Isn't it obvious, Warchief? I serve the Horde.
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 20, 5000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 20:
                        Say(_garroshGUID, 6, 5.51524f);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 21, 4500);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 21:
                        if (Creature* garrosh = Actor(_garroshGUID))
                            if (Creature* cromush = Actor(_cromushGUID))
                                garrosh->SetFacingToObject(cromush);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 22, 500);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 22:
                        Say(_garroshGUID, 7, -1.0f, ANIMKIT_GARROSH_2);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 23, 14000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 23:
                        if (Creature* cromush = Actor(_cromushGUID))
                            if (Creature* garrosh = Actor(_garroshGUID))
                                cromush->SetFacingToObject(garrosh);
                        Say(_cromushGUID, 1);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 24, 2500);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 24:
                        Say(_garroshGUID, 8, 5.6199603f, ANIMKIT_GARROSH_2);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 25, 8500);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 25:
                        if (Creature* garrosh = Actor(_garroshGUID))
                        {
                            garrosh->CastSpell(garrosh, SPELL_WELCOME_TO_SILVERPINE_CREDIT, true);
                            garrosh->GetMotionMaster()->MovePath(PATH_GARROSH_COMETH, false);
                        }
                        else
                            DoCast(me, SPELL_WELCOME_TO_SILVERPINE_CREDIT, true); // still credit the players around Mortuus
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 26, 9000);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 26:
                        for (uint64 guid : _summons)
                            if (Creature* summon = Actor(guid))
                                summon->CastSpell(summon, SPELL_SIMPLE_TELEPORT, false);
                        _events.ScheduleEvent(EVENT_SCENE_TALK_COMETH + 27, 500);
                        break;
                    case EVENT_SCENE_TALK_COMETH + 27:
                        Reset(); // despawns the summons
                        break;
                    default:
                        break;
                }
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
        SummonList _summons;
        uint64 _garroshGUID = 0;
        uint64 _cromushGUID = 0;
        uint64 _sylvanasGUID = 0;
        uint64 _agathaGUID = 0;
        bool _eventInProgress;
    };

    enum RaiseForsakenCometh
    {
        ACTION_RISE_DURING_RAISE                = 1,
        ACTION_DESCEND_AFTER_RAISE              = 2,

        POINT_BEING_RISEN                       = 1
        // TrinityCore also sets AI anim kit 721 (floating pose) while risen; SkyFire has no SMSG_SET_AI_ANIM_KIT.
    };

    // 83173 - Raise Forsaken
    class spell_silverpine_raise_forsaken_83173 : public AuraScript
    {
        PrepareAuraScript(spell_silverpine_raise_forsaken_83173);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Creature* fallenHuman = GetTarget()->ToCreature())
                if (fallenHuman->IsAIEnabled)
                    fallenHuman->AI()->DoAction(ACTION_RISE_DURING_RAISE);
        }

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Creature* fallenHuman = GetTarget()->ToCreature())
                if (fallenHuman->IsAIEnabled)
                    fallenHuman->AI()->DoAction(ACTION_DESCEND_AFTER_RAISE);
        }

        void Register() OVERRIDE
        {
            OnEffectApply += AuraEffectApplyFn(spell_silverpine_raise_forsaken_83173::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_silverpine_raise_forsaken_83173::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    enum FallenHuman
    {
        SPELL_FEIGNED                           = 80636,
        SPELL_FORSAKEN_TROOPER_MS_COMETH        = 83149,

        EVENT_ASCEND                            = 1,
        EVENT_TRANSFORM_INTO_FORSAKEN           = 2,
        EVENT_FACE_TOWARDS_SYLVANAS             = 3,
        EVENT_EMOTE_TO_SYLVANAS                 = 4
    };

    // 44592, 44593 - Fallen Human
    struct npc_silverpine_fallen_human : public ScriptedAI
    {
        npc_silverpine_fallen_human(Creature* creature) : ScriptedAI(creature), _transformDone(false) { }

        void Reset() OVERRIDE
        {
            _transformDone = false;
            _events.Reset();
        }

        void DoAction(int32 action) OVERRIDE
        {
            switch (action)
            {
                case ACTION_RISE_DURING_RAISE:
                    _events.ScheduleEvent(EVENT_ASCEND, 1000);
                    break;
                case ACTION_DESCEND_AFTER_RAISE:
                    me->SetWalk(false);
                    me->GetMotionMaster()->MoveFall();
                    _events.ScheduleEvent(EVENT_TRANSFORM_INTO_FORSAKEN, 1000);
                    break;
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_ASCEND:
                        me->SetWalk(true);
                        me->GetMotionMaster()->MovePoint(POINT_BEING_RISEN, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 3.5f, false);
                        break;
                    case EVENT_TRANSFORM_INTO_FORSAKEN:
                        if (_transformDone)
                            break;
                        _transformDone = true;
                        DoCast(me, SPELL_FORSAKEN_TROOPER_MS_COMETH);
                        _events.ScheduleEvent(EVENT_FACE_TOWARDS_SYLVANAS, 1500);
                        break;
                    case EVENT_FACE_TOWARDS_SYLVANAS:
                        me->SetFacingTo(0.706837f);
                        _events.ScheduleEvent(EVENT_EMOTE_TO_SYLVANAS, 2500);
                        break;
                    case EVENT_EMOTE_TO_SYLVANAS:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                        me->DespawnOrUnsummon(80000); // respawns lying down (spawntimesecs 1)
                        break;
                    default:
                        break;
                }
            }
        }

    private:
        EventMap _events;
        bool _transformDone;
    };

    enum SpellForsakenTrooperMasterScriptCometh
    {
        SPELL_FORSAKEN_TROOPER_MALE_01_HC       = 83150,
        SPELL_FORSAKEN_TROOPER_MALE_02_HC       = 83163,
        SPELL_FORSAKEN_TROOPER_MALE_03_HC       = 83164,
        SPELL_FORSAKEN_TROOPER_MALE_04_HC       = 83165,
        SPELL_FORSAKEN_TROOPER_FEMALE_01_HC     = 83152,
        SPELL_FORSAKEN_TROOPER_FEMALE_02_HC     = 83166,
        SPELL_FORSAKEN_TROOPER_FEMALE_03_HC     = 83167,
        SPELL_FORSAKEN_TROOPER_FEMALE_04_HC     = 83168,

        DISPLAY_MALE_01_HC                      = 33978,
        DISPLAY_MALE_02_HC                      = 33980,
        DISPLAY_MALE_03_HC                      = 33979,
        DISPLAY_MALE_04_HC                      = 33981,
        DISPLAY_FEMALE_01_HC                    = 33982,
        DISPLAY_FEMALE_02_HC                    = 33983,
        DISPLAY_FEMALE_03_HC                    = 33984,
        DISPLAY_FEMALE_04_HC                    = 33985
    };

    // 83149 - Forsaken Trooper Master Script (Forsaken High Command)
    class spell_silverpine_forsaken_trooper_masterscript_high_command : public SpellScript
    {
        PrepareSpellScript(spell_silverpine_forsaken_trooper_masterscript_high_command);

        bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
        {
            for (uint32 spellId : { SPELL_FORSAKEN_TROOPER_MALE_01_HC, SPELL_FORSAKEN_TROOPER_MALE_02_HC, SPELL_FORSAKEN_TROOPER_MALE_03_HC,
                SPELL_FORSAKEN_TROOPER_MALE_04_HC, SPELL_FORSAKEN_TROOPER_FEMALE_01_HC, SPELL_FORSAKEN_TROOPER_FEMALE_02_HC,
                SPELL_FORSAKEN_TROOPER_FEMALE_03_HC, SPELL_FORSAKEN_TROOPER_FEMALE_04_HC })
                if (!sSpellMgr->GetSpellInfo(spellId))
                    return false;
            return true;
        }

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            if (!caster)
                return;

            caster->RemoveAurasDueToSpell(SPELL_FEIGNED);

            uint32 spellId = SPELL_FORSAKEN_TROOPER_MALE_01_HC;
            switch (caster->GetDisplayId())
            {
                case DISPLAY_MALE_01_HC:   spellId = SPELL_FORSAKEN_TROOPER_MALE_01_HC;   break;
                case DISPLAY_MALE_02_HC:   spellId = SPELL_FORSAKEN_TROOPER_MALE_02_HC;   break;
                case DISPLAY_MALE_03_HC:   spellId = SPELL_FORSAKEN_TROOPER_MALE_03_HC;   break;
                case DISPLAY_MALE_04_HC:   spellId = SPELL_FORSAKEN_TROOPER_MALE_04_HC;   break;
                case DISPLAY_FEMALE_01_HC: spellId = SPELL_FORSAKEN_TROOPER_FEMALE_01_HC; break;
                case DISPLAY_FEMALE_02_HC: spellId = SPELL_FORSAKEN_TROOPER_FEMALE_02_HC; break;
                case DISPLAY_FEMALE_03_HC: spellId = SPELL_FORSAKEN_TROOPER_FEMALE_03_HC; break;
                case DISPLAY_FEMALE_04_HC: spellId = SPELL_FORSAKEN_TROOPER_FEMALE_04_HC; break;
                default: break;
            }

            caster->CastSpell(caster, spellId, true);
        }

        void Register() OVERRIDE
        {
            OnEffectHitTarget += SpellEffectFn(spell_silverpine_forsaken_trooper_masterscript_high_command::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };
}

/*######
## AddSC
######*/

void AddSC_silverpine_forest()
{
    new npc_deathstalker_erland();
    RegisterCreatureAI(npc_silverpine_grand_executor_mortuus);
    RegisterAuraScript(spell_silverpine_raise_forsaken_83173);
    RegisterCreatureAI(npc_silverpine_fallen_human);
    RegisterSpellScript(spell_silverpine_forsaken_trooper_masterscript_high_command);
}
