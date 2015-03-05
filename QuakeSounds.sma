
/*************************************************************************************
******* PRAGMA ***********************************************************************
*************************************************************************************/

// WHETHER OR NOT TO FORCE ';' AFTER EACH LINE
//
// #pragma semicolon 1

// WHETHER OR NOT TO INCREASE MEMORY FOR THIS SCRIPT
// 1000000 BYTES = 1 MEGABYTE
//
// #pragma dynamic 1000000 * 4

// WHETHER OR NOT TO USE '\' AS A CONTROL CHARACTER
// INSTEAD OF THE DEFAULT ONE, WHICH IS '^'
//
// #pragma ctrlchar '\'

// SETS TAB SIZE '\t' TO 0
// GLOBALLY
//
#pragma tabsize 0


/*************************************************************************************
******* HEADERS **********************************************************************
*************************************************************************************/

// AMX MOD X HEADER FILE
//
#include <amxmodx>


/*************************************************************************************
******* DEFINITIONS ******************************************************************
*************************************************************************************/

// VERSION
//
#define QS_VERSION "5.0"

// INVALID PLAYER
//
#define QS_INVALIDPLR 0xFF

// MAXIMUM PLAYERS
//
#define QS_MAXPLRS 32

// MAXIMUM BYTE (8 BIT)
//
#define QS_MAX8BIT 0xFF

// INVALID TEAM
//
#define QS_INVALIDTEAM 0xFF

// HUD MESSAGE PURPOSES
//
enum /* HUDMSG PURPOSE */
{
	HUDMSG_EVENT = 0,
	HUDMSG_KILL,
	HUDMSG_ROUND,

	HUDMSG_MAX
};


/*************************************************************************************
******* GLOBAL VARIABLES *************************************************************
*************************************************************************************/

// PLUG-IN ON/ OFF
//
new bool:g_bON = false;

/**
* HEAD SHOT
*/

// HEAD SHOT ON/ OFF
//
new bool:g_bHShot = false;
new bool:g_bHShotMsg = false;

new g_HShotMsg[256];

new g_HShotSize = 0;

// HEAD SHOT ONLY FOR KILLER
//
new bool:g_bHShotOnlyKiller = false;

// HEAD SHOT SOUNDS CONTAINER
//
new Array:g_pHShot = Invalid_Array;

/**
* REVENGE
*/

// REVENGE ON/ OFF
//
new bool:g_bRevenge = false;

new bool:g_bRevengeMsgKiller = false;
new bool:g_bRevengeMsgVictim = false;

new g_RevengeMsgKiller[256];
new g_RevengeMsgVictim[256];

new g_RevengeSize = 0;

// REVENGE ONLY FOR KILER
//
new bool:g_bRevengeOnlyKiller = false;

// REVENGE SOUNDS CONTAINER
//
new Array:g_pRevenge = Invalid_Array;

/**
* HATTRICK
* THE ROUND LEADER
*/

// HATTRICK ON/ OFF
//
new bool:g_bHattrick = false;
new bool:g_bHattrickMsg = false;

new g_HattrickMsg[256];

new g_HattrickSize = 0;

// MINIMUM KILLS REQUIRED FOR HATTRICK
//
new g_MinimumKillsForHattrick = 0;

// HATTRICK SOUNDS CONTAINER
//
new Array:g_pHattrick = Invalid_Array;

/**
* SUICIDE
*/

// SUICIDE ON/ OFF
//
new bool:g_bSuicide = false;
new bool:g_bSuicideMsg = false;

new g_SuicideMsg[256];

new g_SuicideSize = 0;

// SUICIDE SOUNDS CONTAINER
//
new Array:g_pSuicide = Invalid_Array;

/**
* GRENADE
*/

// GRENADE ON/ OFF
//
new bool:g_bGrenade = false;
new bool:g_bGrenadeMsg = false;

new g_GrenadeMsg[256];

new g_GrenadeSize = 0;

// GRENADE SOUNDS CONTAINER
//
new Array:g_pGrenade = Invalid_Array;

/**
* TEAM KILL
*/

// TEAM KILL ON/ OFF
//
new bool:g_bTKill = false;
new bool:g_bTKillMsg = false;

new g_TKillMsg[256];

new g_TKillSize = 0;

// TEAM KILL SOUNDS CONTAINER
//
new Array:g_pTKill = Invalid_Array;

/**
* KNIFE
*/

// KNIFE ON/ OFF
//
new bool:g_bKnife = false;
new bool:g_bKnifeMsg = false;

new g_KnifeMsg[256];

new g_KnifeSize = 0;

// KNIFE SOUNDS CONTAINER
//
new Array:g_pKnife = Invalid_Array;

/**
* FIRST BLOOD
*/

// FIRST BLOOD ON/ OFF
//
new bool:g_bFBlood = false;
new bool:g_bFBloodMsg = false;

new g_FBloodMsg[256];

new g_FBloodSize = 0;

new g_FBlood = 0;

// FIRST BLOOD SOUNDS CONTAINER
//
new Array:g_pFBlood = Invalid_Array;

/**
* KILLS STREAK
*/

// KILLS STREAK ON/ OFF
//
new bool:g_bKStreak = false;

new g_KStreakSoundsSize = 0;

// KILLS STREAK SOUNDS CONTAINER
//
new Array:g_pKStreakSounds = Invalid_Array;

// KILLS STREAK MESSAGES CONTAINER
//
new Array:g_pKStreakMessages = Invalid_Array;

// KILLS STREAK REQUIRED KILLS CONTAINER
//
new Array:g_pKStreakRequiredKills = Invalid_Array;

/**
* ROUND START
*/

// ROUND START ON/ OFF
//
new bool:g_bRStart = false;
new bool:g_bRStartMsg = false;

new g_RStartMsg[256];

new g_RStartSize = 0;

// ROUND START SOUNDS CONTAINER
//
new Array:g_pRStart = Invalid_Array;

/**
* DOUBLE KILL
*/

// DOUBLE KILL ON/ OFF
//
new bool:g_bDKill = false;
new bool:g_bDKillMsg = false;

new g_DKillMsg[256];

new g_DKillSize = 0;

// DOUBLE KILL SOUNDS CONTAINER
//
new Array:g_pDKill = Invalid_Array;

/**
* FLAWLESS
* IF A TEAM KILLS THE OTHER ONE W/ O GETTING ANY CASUALTIES
*/

// FLAWLESS ON/ OFF
//
new bool:g_bFlawless = false;
new bool:g_bFlawlessMsg = false;

new g_FlawlessMsg[256];

// TEAM NAMES
//
new g_FlawlessTName[256];
new g_FlawlessCTName[256];

new g_FlawlessSize = 0;

// FLAWLESS SOUNDS CONTAINER
//
new Array:g_pFlawless = Invalid_Array;


/**
* HUD MESSAGE [TE_TEXTMESSAGE]
*/

// CHANNEL HANDLES
//
new g_pHudMsg[HUDMSG_MAX];


// RED
//
new g_Red = 0;

// RANDOM RED
//
new bool:g_bRandomRed = false;

// GREEN
//
new g_Green = 0;

// RANDOM GREEN
//
new bool:g_bRandomGreen = false;

// BLUE
//
new g_Blue = 0;

// RANDOM BLUE
//
new bool:g_bRandomBlue = false;


/**
* PLAYERS RELATED
*/

// MAXIMUM PLAYERS
//
new g_maxPlayers = 0;

// TOTAL KILLS PER PLAYER PER LIFE
// RESETS ON DEATH
//
new g_Kills[QS_MAXPLRS + 1];

// TOTAL KILLS PER PLAYER PER ROUND
// RESETS NEXT ROUND
//
new g_RKills[QS_MAXPLRS + 1];

// HLTV
//
new bool:g_bHLTV[QS_MAXPLRS + 1];

// BOT
//
new bool:g_bBOT[QS_MAXPLRS + 1];

// CONNECTED
//
new bool:g_bConnected[QS_MAXPLRS + 1];

// NAME
//
new g_Name[QS_MAXPLRS + 1][32];

// REVENGE KILL
//
new g_RevengeStamp[QS_MAXPLRS + 1][32];

// DISABLED
//
new bool:g_bDisabled[QS_MAXPLRS + 1];

// LAST KILL
//
new Float:g_fLastKillStamp[QS_MAXPLRS + 1];

/*************************************************************************************
******* FORWARDS *********************************************************************
*************************************************************************************/

// pfnSpawn()
// CALLED BEFORE "plugin_init"
// THE RIGHT MOMENT FOR INI FILES
// AND PRECACHING DATA
//
public plugin_precache()
{
	// CREATES ARRAYS FIRST
	//
	g_pHShot = ArrayCreate(128);
	g_pSuicide = ArrayCreate(128);
	g_pGrenade = ArrayCreate(128);
	g_pTKill = ArrayCreate(128);
	g_pKnife = ArrayCreate(128);
	g_pFBlood = ArrayCreate(128);
	g_pRStart = ArrayCreate(128);
	g_pDKill = ArrayCreate(128);
	g_pHattrick = ArrayCreate(128);
	g_pFlawless = ArrayCreate(128);
	g_pRevenge = ArrayCreate(128);
	g_pKStreakSounds = ArrayCreate(128);
	g_pKStreakMessages = ArrayCreate(256);
	g_pKStreakRequiredKills = ArrayCreate(8);

	// READS FILE
	//
	LoadFile();

	// PRECACHES NOTHING
	// IF PLUG-IN IS OFF
	//
	if (!g_bON)
		return;

	g_HShotSize = ArraySize(g_pHShot);
	g_SuicideSize = ArraySize(g_pSuicide);
	g_GrenadeSize = ArraySize(g_pGrenade);
	g_TKillSize = ArraySize(g_pTKill);
	g_KnifeSize = ArraySize(g_pKnife);
	g_FBloodSize = ArraySize(g_pFBlood);
	g_RStartSize = ArraySize(g_pRStart);
	g_DKillSize = ArraySize(g_pDKill);
	g_HattrickSize = ArraySize(g_pHattrick);
	g_FlawlessSize = ArraySize(g_pFlawless);
	g_RevengeSize = ArraySize(g_pRevenge);
	g_KStreakSoundsSize = ArraySize(g_pKStreakSounds);

	// DEFINES ITERATOR FOR FURTHER USE
	//
	new Iterator = 0;

	// DEFINES SOUND FOR FURTHER USE
	//
	new Sound[128];

	// HEAD SHOT
	if (g_bHShot)
	{
		for (Iterator = 0; Iterator < g_HShotSize; Iterator++)
		{
			ArrayGetString(g_pHShot, Iterator, Sound, charsmax(Sound));
			precache_sound(Sound);
		}
	}

	if (g_bSuicide)
	{
		for (Iterator = 0; Iterator < g_SuicideSize; Iterator++)
		{
			ArrayGetString(g_pSuicide, Iterator, Sound, charsmax(Sound));
			precache_sound(Sound);
		}
	}

	if (g_bGrenade)
	{
		for (Iterator = 0; Iterator < g_GrenadeSize; Iterator++)
		{
			ArrayGetString(g_pGrenade, Iterator, Sound, charsmax(Sound));
			precache_sound(Sound);
		}
	}

	if (g_bTKill)
	{
		for (Iterator = 0; Iterator < g_TKillSize; Iterator++)
		{
			ArrayGetString(g_pTKill, Iterator, Sound, charsmax(Sound));
			precache_sound(Sound);
		}
	}

	if (g_bKnife)
	{
		for (Iterator = 0; Iterator < g_KnifeSize; Iterator++)
		{
			ArrayGetString(g_pKnife, Iterator, Sound, charsmax(Sound));
			precache_sound(Sound);
		}
	}

	if (g_bFBlood)
	{
		for (Iterator = 0; Iterator < g_FBloodSize; Iterator++)
		{
			ArrayGetString(g_pFBlood, Iterator, Sound, charsmax(Sound));
			precache_sound(Sound);
		}
	}

	if (g_bRStart)
	{
		for (Iterator = 0; Iterator < g_RStartSize; Iterator++)
		{
			ArrayGetString(g_pRStart, Iterator, Sound, charsmax(Sound));
			precache_sound(Sound);
		}
	}

	if (g_bDKill)
	{
		for (Iterator = 0; Iterator < g_DKillSize; Iterator++)
		{
			ArrayGetString(g_pDKill, Iterator, Sound, charsmax(Sound));
			precache_sound(Sound);
		}
	}

	if (g_bHattrick)
	{
		for (Iterator = 0; Iterator < g_HattrickSize; Iterator++)
		{
			ArrayGetString(g_pHattrick, Iterator, Sound, charsmax(Sound));
			precache_sound(Sound);
		}
	}

	if (g_bFlawless)
	{
		for (Iterator = 0; Iterator < g_FlawlessSize; Iterator++)
		{
			ArrayGetString(g_pFlawless, Iterator, Sound, charsmax(Sound));
			precache_sound(Sound);
		}
	}

	if (g_bRevenge)
	{
		for (Iterator = 0; Iterator < g_RevengeSize; Iterator++)
		{
			ArrayGetString(g_pRevenge, Iterator, Sound, charsmax(Sound));
			precache_sound(Sound);
		}
	}

	if (g_bKStreak)
	{
		for (Iterator = 0; Iterator < g_KStreakSoundsSize; Iterator++)
		{
			ArrayGetString(g_pKStreakSounds, Iterator, Sound, charsmax(Sound));
			precache_sound(Sound);
		}
	}
}

// pfnServerActivate_Post()
// CALLED AFTER "plugin_precache"
// THE RIGHT MOMENT FOR REGISTERING STUFF
//
public plugin_init()
{
	// REGISTERS PLUG-IN
	//
	register_plugin("ADV. QUAKE SOUNDS", QS_VERSION, "HATTRICK (HTTRCKCLDHKS)");

	// REGISTERS CONSOLE VARIABLE
	//
	new pCVar = register_cvar("advanced_quake_sounds", QS_VERSION, FCVAR_SERVER | FCVAR_EXTDLL | FCVAR_UNLOGGED | FCVAR_SPONLY);

	// SETS CONSOLE VARIABLE STRING
	//
	if (pCVar)
		set_pcvar_string(pCVar, QS_VERSION);

	// STOPS HERE IF THE PLUG-IN IS DISABLED
	//
	if (!g_bON)
		return;

	// GETS MAXIMUM PLAYERS
	//
	g_maxPlayers = get_maxplayers();

	// DEATHMSG FOR ALL GAMES
	//
	register_event("DeathMsg", "OnDeathMsg", "a");

	// GETS MOD NAME
	//
	new ModName[8];
	get_modname(ModName, charsmax(ModName));

	// ROUND RESTART
	//
	register_event("TextMsg", "OnRRestart", "a", "2&#Game_C", "2&#Game_w");

	// COUNTER-STRIKE
	//
	if (equali(ModName, "CS", 2) || equali(ModName, "CZ", 2))
	{
		register_logevent("OnRStart", 2, "1=Round_Start");
		register_logevent("OnREnd", 2, "1=Round_End");
	}

	// DAY OF DEFEAT
	//
	else if (equali(ModName, "DoD", 3))
	{
		register_event("RoundState", "OnRStart", "a", "1=1");
		register_event("RoundState", "OnREnd", "a", "1=3", "1=4");
	}

	// NO CS/ CZ OR DOD
	//
	else
	{
		// DISABLES TEAM KILL
		//
		g_bTKill = false;

		// DISABLES HATTRICK
		//
		g_bHattrick = false;

		// DISABLES FLAWLESS
		//
		g_bFlawless = false;

		// DISABLES ROUND START
		//
		g_bRStart = false;

		// DISABLES FIRST BLOOD
		//
		g_bFBlood = false;
	}

	// HUD MESSAGE [TE_TEXTMESSAGE] CHANNEL HANDLES
	//
	g_pHudMsg[HUDMSG_KILL] = CreateHudSyncObj();
	g_pHudMsg[HUDMSG_EVENT] = CreateHudSyncObj();
	g_pHudMsg[HUDMSG_ROUND] = CreateHudSyncObj();
}

// pfnServerActivate_Post()
// CALLED AFTER "plugin_init"
// THE RIGHT MOMENT FOR ACTUALIZING CONFIGURATIONS
//
public plugin_cfg()
{
	g_bHShotMsg = g_HShotMsg[0] ? true : false;
	g_bSuicideMsg = g_SuicideMsg[0] ? true : false;
	g_bGrenadeMsg = g_GrenadeMsg[0] ? true : false;
	g_bTKillMsg = g_TKillMsg[0] ? true : false;
	g_bKnifeMsg = g_KnifeMsg[0] ? true : false;
	g_bFBloodMsg = g_FBloodMsg[0] ? true : false;
	g_bRStartMsg = g_RStartMsg[0] ? true : false;
	g_bDKillMsg = g_DKillMsg[0] ? true : false;
	g_bHattrickMsg = g_HattrickMsg[0] ? true : false;
	g_bFlawlessMsg = g_FlawlessMsg[0] ? true : false;
	g_bRevengeMsgVictim = g_RevengeMsgVictim[0] ? true : false;
	g_bRevengeMsgKiller = g_RevengeMsgKiller[0] ? true : false;
}

// pfnClientUserInfoChanged()
// EXECUTES WHEN CLIENT CHANGES INFORMATION
//
public client_infochanged(Player)
{
	static newName[32];

	if (g_bConnected[Player] && !g_bHLTV[Player])
	{
		get_user_info(Player, "name", newName, charsmax(newName));

		if (!equali(newName, g_Name[Player]))
			g_Name[Player] = newName;
	}
}

// pfnClientDisconnect()
// EXECUTES WHEN CLIENT DISCONNECTS
//
public client_disconnect(Player)
{
	g_Kills[Player] = 0;
	g_RKills[Player] = 0;

	g_bHLTV[Player] = false;
	g_bBOT[Player] = false;
	g_bDisabled[Player] = false;
	g_bConnected[Player] = false;

	g_Name[Player][0] = '^0';
	g_RevengeStamp[Player][0] = '^0';
}

// pfnClientCommand()
// EXECUTES WHEN CLIENT TYPES
//
public client_command(Player)
{
	static Argument[16];

	if (is_user_connected(Player) && !g_bBOT[Player] && !g_bHLTV[Player])
	{
		read_argv(1, Argument, charsmax(Argument));

		if (equali(Argument, "/Sounds", 7) || equali(Argument, "Sounds", 6))
		{
			client_print(Player, print_chat, ">> QUAKE SOUNDS HAVE BEEN %s.", g_bDisabled[Player] ? "ENABLED" : "DISABLED");
			g_bDisabled[Player] = !g_bDisabled[Player];
		}
	}
}

// pfnClientPutInServer()
// EXECUTES WHEN CLIENT JOINS
//
public client_putinserver(Player)
{
	get_user_name(Player, g_Name[Player], charsmax(g_Name[]));

	g_bHLTV[Player] = bool:is_user_hltv(Player);
	g_bBOT[Player ] = bool:is_user_bot(Player);

	g_Kills[Player] = 0;
	g_RKills[Player] = 0;

	g_bConnected[Player] = true;
	g_bDisabled[Player] = false;

	g_RevengeStamp[Player][0] = '^0';

	if (!g_bBOT[Player] && !g_bHLTV[Player])
		set_task(6.0, "QuakeSoundsPrint", Player);
}

public QuakeSoundsPrint(Player)
{
	if (is_user_connected(Player))
		client_print(Player, print_chat, ">> TYPE 'sounds' TO TURN QUAKE SOUNDS ON OR OFF.");
}

// EXECUTED ON PLAYER DEATH
//
public OnDeathMsg()
{
	static Killer, Victim, Iterator, bool:bHShot, Weapon[32], Float:gameTime, Sound[128], Message[256];

	Killer = read_data(1);
	Victim = read_data(2);

	g_Kills[Victim] = 0;

	// KILLED BY WORLD
	//
	if (Killer == 0)
		return;

	// HEAD SHOT
	//
	bHShot = bool:read_data(3);

	// GAME TIME
	//
	gameTime = get_gametime();

	// WEAPON
	//
	read_data(4, Weapon, charsmax(Weapon));

	if (g_bRandomRed) g_Red = random_num(0, QS_MAX8BIT);
	if (g_bRandomGreen) g_Green = random_num(0, QS_MAX8BIT);
	if (g_bRandomBlue) g_Blue = random_num(0, QS_MAX8BIT);

	set_hudmessage(g_Red, g_Green, g_Blue, -1.0, 0.2415, _, _, 5.0);

	g_Kills[Killer]++;
	g_RKills[Killer]++;

	// REVENGE KILLER STAMP
	//
	g_RevengeStamp[Victim] = g_Name[Killer];

	// SUICIDE
	//
	if (Victim == Killer)
	{
		if (g_bSuicide)
		{
			if (g_bSuicideMsg)
				qs_ShowSyncHudMsg(0, g_pHudMsg[HUDMSG_EVENT], g_SuicideMsg, g_Name[Victim]);

			qs_client_cmd(0, "SPK ^"%a^"", ArrayGetStringHandle(g_pSuicide, random_num(0, g_SuicideSize - 1)));
		}

		if (g_bHattrick)
			g_RKills[Victim]--;
	}
	
	else
	{
		if (g_bRevenge && equali(g_Name[Victim], g_RevengeStamp[Killer]))
		{
			g_RevengeStamp[Killer][0] = '^0';

			if (g_bRevengeMsgKiller)
				qs_ShowSyncHudMsg(Killer, g_pHudMsg[HUDMSG_EVENT], g_RevengeMsgKiller, g_Name[Victim]);

			if (g_bRevengeMsgVictim && !g_bRevengeOnlyKiller)
				qs_ShowSyncHudMsg(Victim, g_pHudMsg[HUDMSG_EVENT], g_RevengeMsgVictim, g_Name[Killer]);

			qs_client_cmd(Killer, "SPK ^"%a^"", ArrayGetStringHandle(g_pRevenge, random_num(0, g_RevengeSize - 1)));

			if (!g_bRevengeOnlyKiller)
				qs_client_cmd(Victim, "SPK ^"%a^"", ArrayGetStringHandle(g_pRevenge, random_num(0, g_RevengeSize - 1)));
		}

		if (bHShot && g_bHShot)
		{
			if (g_bHShotMsg)
				qs_ShowSyncHudMsg(0, g_pHudMsg[HUDMSG_EVENT], g_HShotMsg, g_Name[Killer], g_Name[Victim]);

			qs_client_cmd(g_bHShotOnlyKiller ? Killer : 0, "SPK ^"%a^"", ArrayGetStringHandle(g_pHShot, random_num(0, g_HShotSize - 1)));
		}

		if (++g_FBlood == 1 && g_bFBlood)
		{
			if (g_bFBloodMsg)
				qs_ShowSyncHudMsg(0, g_pHudMsg[HUDMSG_EVENT], g_FBloodMsg, g_Name[Killer]);

			qs_client_cmd(0, "SPK ^"%a^"", ArrayGetStringHandle(g_pFBlood, random_num(0, g_FBloodSize - 1)));
		}

		if (get_user_team(Victim) == get_user_team(Killer) && g_bTKill)
		{
			if (g_bTKillMsg)
				qs_ShowSyncHudMsg(0, g_pHudMsg[HUDMSG_EVENT], g_TKillMsg, g_Name[Killer]);

			qs_client_cmd(0, "SPK ^"%a^"", ArrayGetStringHandle(g_pTKill, random_num(0, g_TKillSize - 1)));
		}

		// CHECKS FOR GRENADE FIRST
		//
		if (g_bGrenade && (containi(Weapon, "Chreck") != -1 || containi(Weapon, "Rocket") != -1 || containi(Weapon, "MK") != -1 || \
			containi(Weapon, "Granate") != -1 || containi(Weapon, "Bomb") != -1 || containi(Weapon, "Grenade") != -1 || \
			containi(Weapon, "PIAT") != -1 || containi(Weapon, "Bazooka") != -1 || containi(Weapon, "Panzer") != -1))
		{
			if (g_bGrenadeMsg)
				qs_ShowSyncHudMsg(0, g_pHudMsg[HUDMSG_EVENT], g_GrenadeMsg, g_Name[Killer], g_Name[Victim]);

			qs_client_cmd(0, "SPK ^"%a^"", ArrayGetStringHandle(g_pGrenade, random_num(0, g_GrenadeSize - 1)));
		}

		if ((containi(Weapon, "Knife") != -1 || containi(Weapon, "Spade") != -1 || containi(Weapon, "Satchel") != -1) && g_bKnife)
		{
			if (g_bKnifeMsg)
				qs_ShowSyncHudMsg(0, g_pHudMsg[HUDMSG_EVENT], g_KnifeMsg, g_Name[Killer], g_Name[Victim]);

			qs_client_cmd(0, "SPK ^"%a^"", ArrayGetStringHandle(g_pKnife, random_num(0, g_KnifeSize - 1)));
		}

		if (g_fLastKillStamp[Killer] > gameTime && g_bDKill)
		{
			if (g_bDKillMsg)
				qs_ShowSyncHudMsg(0, g_pHudMsg[HUDMSG_EVENT], g_DKillMsg, g_Name[Killer], g_Name[Victim]);

			qs_client_cmd(0, "SPK ^"%a^"", ArrayGetStringHandle(g_pDKill, random_num(0, g_DKillSize - 1)));
		}

		g_fLastKillStamp[Killer] = gameTime + 0.1;

		if (g_bKStreak)
		{
			for (Iterator = 0; Iterator < g_KStreakSoundsSize; Iterator++)
			{
				if (g_Kills[Killer] == ArrayGetCell(g_pKStreakRequiredKills, Iterator))
				{
					ArrayGetString(g_pKStreakMessages, Iterator, Message, charsmax(Message));
					ArrayGetString(g_pKStreakSounds, Iterator, Sound, charsmax(Sound));

					__Display(Killer, Message, Sound);

					break;
				}
			}
		}
	}
}

public OnRRestart()
{
	for (new Player = 1; Player <= g_maxPlayers; Player++)
	{
		g_Kills[Player] = 0;
		g_RKills[Player] = 0;

		g_RevengeStamp[Player][0] = '^0';
	}
}

public OnRStart()
{
	static Iterator;

	if (g_bFBlood)
		g_FBlood = 0;

	if (g_bRStart)
	{
		if (g_bRStartMsg)
		{
			if (g_bRandomRed) g_Red = random_num(0, QS_MAX8BIT);
			if (g_bRandomGreen) g_Green = random_num(0, QS_MAX8BIT);
			if (g_bRandomBlue) g_Blue = random_num(0, QS_MAX8BIT);

			set_hudmessage(g_Red, g_Green, g_Blue, -1.0, 0.2615, _, _, 5.0);
			qs_ShowSyncHudMsg(0, g_pHudMsg[HUDMSG_ROUND], g_RStartMsg);
		}

		qs_client_cmd(0, "SPK ^"%a^"", ArrayGetStringHandle(g_pRStart, random_num(0, g_RStartSize - 1)));
	}

	if (g_bHattrick)
	{
		for (Iterator = 1; Iterator <= g_maxPlayers; Iterator++)
			g_RKills[Iterator] = 0;
	}
}

public OnREnd()
{
	if (g_bHattrick) set_task(2.8, "__Hattrick");
	if (g_bFlawless) set_task(1.2, "__Flawless");
}

public __Hattrick()
{
	static Leader;
	Leader = __Leader();

	if (Leader != QS_INVALIDPLR)
	{
		if (g_bRandomRed) g_Red = random_num(0, QS_MAX8BIT);
		if (g_bRandomGreen) g_Green = random_num(0, QS_MAX8BIT);
		if (g_bRandomBlue) g_Blue = random_num(0, QS_MAX8BIT);

		if (g_RKills[Leader] >= g_MinimumKillsForHattrick)
		{
			if (g_bHattrickMsg)
			{
				set_hudmessage(g_Red, g_Green, g_Blue, -1.0, 0.2015, _, _, 5.0);
				qs_ShowSyncHudMsg(0, g_pHudMsg[HUDMSG_EVENT], g_HattrickMsg, g_Name[Leader]);
			}

			qs_client_cmd(0, "SPK ^"%a^"", ArrayGetStringHandle(g_pHattrick, random_num(0, g_HattrickSize - 1)));
		}
	}
}

// PREPARES FLAWLESS
//
public __Flawless()
{
	if (g_bRandomRed) g_Red = random_num(0, QS_MAX8BIT);
	if (g_bRandomGreen) g_Green = random_num(0, QS_MAX8BIT);
	if (g_bRandomBlue) g_Blue = random_num(0, QS_MAX8BIT);

	new aliveTeam_1 = __Players(true, 1);
	new aliveTeam_2 = __Players(true, 2);

	new allTeam_1 = aliveTeam_1 + __Players(false, 1);
	new allTeam_2 = aliveTeam_2 + __Players(false, 2);

	set_hudmessage(g_Red, g_Green, g_Blue, -1.0, 0.2815, _, _, 5.0);

	if (allTeam_1 == aliveTeam_1)
	{
		if (g_bFlawlessMsg)
			qs_ShowSyncHudMsg(0, g_pHudMsg[HUDMSG_ROUND], g_FlawlessMsg, g_FlawlessTName);

		qs_client_cmd(0, "SPK ^"%a^"", ArrayGetStringHandle(g_pFlawless, random_num(0, g_FlawlessSize - 1)));
	}

	else if (allTeam_2 == aliveTeam_2)
	{
		if (g_bFlawlessMsg)
			qs_ShowSyncHudMsg(0, g_pHudMsg[HUDMSG_ROUND], g_FlawlessMsg, g_FlawlessCTName);

		qs_client_cmd(0, "SPK ^"%a^"", ArrayGetStringHandle(g_pFlawless, random_num(0, g_FlawlessSize - 1)));
	}
}

/*************************************************************************************
******* FUNCTIONS ********************************************************************
*************************************************************************************/

// LOADS FILE
//
LoadFile()
{
	// PREPARES CONFIGURATIONS FILE DIRECTORY
	//
	new ConfigsDir[256];
	get_localinfo("amxx_configsdir", ConfigsDir, charsmax(ConfigsDir));

	// PREPARES FILE NAME
	//
	new File[256];
	formatex(File, charsmax(File), "%s/quakesounds.ini", ConfigsDir);

	// OPENS FILE
	//
	new pFile = fopen(File, "r");
	if (!pFile)
		return;

	// PREPARES FILE LINE
	//
	new Line[512], Key[64], Value[256], Type[32], Sound[128], RequiredKills[8], Dummy[4], Message[256];

	// READS FILE
	//
	while (!feof(pFile))
	{
		// GETS LINE
		//
		fgets(pFile, Line, charsmax(Line));

		// TRIMS LINE OFF
		//
		trim(Line);

		// CHECK FOR VALIDITY
		//
		if (Line[0] == '^0' || Line[0] == ';' || Line[0] == '#' || (Line[0] == '/' && Line[1] == '/'))
			continue;

		// SPLITS STRING IN TOKENS
		//
		strtok(Line, Key, charsmax(Key), Value, charsmax(Value), '=');

		// TRIMS KEY
		trim(Key);

		// TRIMS VALUE(S)
		trim(Value);

		//
		// SETTINGS
		//

		if (equali(Key, "ENABLE/DISABLE PLUGIN")) g_bON = bool:str_to_num(Value);
		else if (equali(Key, "HEADSHOT ONLY KILLER")) g_bHShotOnlyKiller = bool:str_to_num(Value);
		else if (equali(Key, "MIN FRAGS FOR HATTRICK")) g_MinimumKillsForHattrick = str_to_num(Value);
		else if (equali(Key, "REVENGE ONLY FOR KILLER")) g_bRevengeOnlyKiller = bool:str_to_num(Value);

		//
		// HUD MESSAGES
		//

		else if (equali(Key, "HUDMSG RED"))
		{
			if (equal(Value, "_")) g_bRandomRed = true;
			else g_Red = str_to_num(Value);
		}

		else if (equali(Key, "HUDMSG GREEN"))
		{
			if (equal(Value, "_")) g_bRandomGreen = true;
			else g_Green = str_to_num(Value);
		}

		else if (equali(Key, "HUDMSG BLUE"))
		{
			if (equal(Value, "_")) g_bRandomBlue = true;
			else g_Blue = str_to_num(Value);
		}

		// KILLS STREAK SOUNDS
		//
		else if (equali(Key, "SOUND"))
		{
			parse(Value, Dummy, charsmax(Dummy), Type, charsmax(Type));

			if (equali(Type, "REQUIREDKILLS"))
			{
				parse(Value, Dummy, charsmax(Dummy), Type, charsmax(Type), RequiredKills, charsmax(RequiredKills), \
					Dummy, charsmax(Dummy), Sound, charsmax(Sound));

				ArrayPushString(g_pKStreakSounds, Sound);
				ArrayPushCell(g_pKStreakRequiredKills, str_to_num(RequiredKills));
			}

			else if (equali(Type, "MESSAGE"))
			{
				strtok(Value, Type, charsmax(Type), Message, charsmax(Message), '@');
				trim(Message);

				ArrayPushString(g_pKStreakMessages, Message);
			}
		}

		//
		// EVENTS ON/ OFF
		//

		else if (equali(Key, "KILLSTREAK EVENT")) g_bKStreak = bool:str_to_num(Value);
		else if (equali(Key, "REVENGE EVENT")) g_bRevenge = bool:str_to_num(Value);
		else if (equali(Key, "HEADSHOT EVENT")) g_bHShot = bool:str_to_num(Value);
		else if (equali(Key, "SUICIDE EVENT")) g_bSuicide = bool:str_to_num(Value);
		else if (equali(Key, "NADE EVENT")) g_bGrenade = bool:str_to_num(Value);
		else if (equali(Key, "TEAMKILL EVENT")) g_bTKill = bool:str_to_num(Value);
		else if (equali(Key, "KNIFE EVENT")) g_bKnife = bool:str_to_num(Value);
		else if (equali(Key, "FIRSTBLOOD EVENT")) g_bFBlood = bool:str_to_num(Value);
		else if (equali(Key, "ROUNDSTART EVENT")) g_bRStart = bool:str_to_num(Value);
		else if (equali(Key, "DOUBLEKILL EVENT")) g_bDKill = bool:str_to_num(Value);
		else if (equali(Key, "HATTRICK EVENT")) g_bHattrick = bool:str_to_num(Value);
		else if (equali(Key, "FLAWLESS VICTORY")) g_bFlawless = bool:str_to_num(Value);

		//
		// EVENT SOUNDS
		//

		else if (equali(Key, "HEADSHOT SOUNDS"))
		{
			while (Value[0] != '^0' && strtok(Value, Key, charsmax(Key), Value, charsmax(Value), ','))
			{
				trim(Key), trim(Value);
				ArrayPushString(g_pHShot, Key);
			}
		}

		else if (equali(Key, "REVENGE SOUNDS"))
		{
			while (Value[0] != '^0' && strtok(Value, Key, charsmax(Key), Value, charsmax(Value), ','))
			{
				trim(Key), trim(Value);
				ArrayPushString(g_pRevenge, Key);
			}
		}

		else if (equali(Key, "SUICIDE SOUNDS"))
		{
			while (Value[0] != '^0' && strtok(Value, Key, charsmax(Key), Value, charsmax(Value), ','))
			{
				trim(Key), trim(Value);
				ArrayPushString(g_pSuicide, Key);
			}
		}

		else if (equali(Key, "NADE SOUNDS"))
		{
			while (Value[0] != '^0' && strtok(Value, Key, charsmax(Key), Value, charsmax(Value), ','))
			{
				trim(Key), trim(Value);
				ArrayPushString(g_pGrenade, Key);
			}
		}

		else if (equali(Key, "TEAMKILL SOUNDS"))
		{
			while (Value[0] != '^0' && strtok(Value, Key, charsmax(Key), Value, charsmax(Value), ','))
			{
				trim(Key), trim(Value);
				ArrayPushString(g_pTKill, Key);
			}
		}

		else if (equali(Key, "KNIFE SOUNDS"))
		{
			while (Value[0] != '^0' && strtok(Value, Key, charsmax(Key), Value, charsmax(Value), ','))
			{
				trim(Key), trim(Value);
				ArrayPushString(g_pKnife, Key);
			}
		}

		else if (equali(Key, "FIRSTBLOOD SOUNDS"))
		{
			while (Value[0] != '^0' && strtok(Value, Key, charsmax(Key), Value, charsmax(Value), ','))
			{
				trim(Key), trim(Value);
				ArrayPushString(g_pFBlood, Key);
			}
		}

		else if (equali(Key, "ROUNDSTART SOUNDS"))
		{
			while (Value[0] != '^0' && strtok(Value, Key, charsmax(Key), Value, charsmax(Value), ','))
			{
				trim(Key), trim(Value);
				ArrayPushString(g_pRStart, Key);
			}
		}

		else if (equali(Key, "DOUBLEKILL SOUNDS"))
		{
			while (Value[0] != '^0' && strtok(Value, Key, charsmax(Key), Value, charsmax(Value), ','))
			{
				trim(Key), trim(Value);
				ArrayPushString(g_pDKill, Key);
			}
		}

		else if (equali(Key, "HATTRICK SOUNDS"))
		{
			while (Value[0] != '^0' && strtok(Value, Key, charsmax(Key), Value, charsmax(Value), ','))
			{
				trim(Key), trim(Value);
				ArrayPushString(g_pHattrick, Key);
			}
		}

		else if (equali(Key, "FLAWLESS SOUNDS"))
		{
			while (Value[0] != '^0' && strtok(Value, Key, charsmax(Key), Value, charsmax(Value), ','))
			{
				trim(Key), trim(Value);
				ArrayPushString(g_pFlawless, Key);
			}
		}

		//
		// MESSAGE STRINGS
		//

		else if (equali(Key, "HEADSHOT HUDMSG")) g_HShotMsg = Value;
		else if (equali(Key, "SUICIDE HUDMSG")) g_SuicideMsg = Value;
		else if (equali(Key, "NADE HUDMSG")) g_GrenadeMsg = Value;
		else if (equali(Key, "TEAMKILL HUDMSG")) g_TKillMsg = Value;
		else if (equali(Key, "KNIFE HUDMSG")) g_KnifeMsg = Value;
		else if (equali(Key, "FIRSTBLOOD HUDMSG")) g_FBloodMsg = Value;
		else if (equali(Key, "ROUNDSTART HUDMSG")) g_RStartMsg = Value;
		else if (equali(Key, "DOUBLEKILL HUDMSG")) g_DKillMsg = Value;
		else if (equali(Key, "HATTRICK HUDMSG")) g_HattrickMsg = Value;
		else if (equali(Key, "FLAWLESS VICTORY HUDMSG")) g_FlawlessMsg = Value;
		else if (equali(Key, "REVENGE KILLER MESSAGE")) g_RevengeMsgKiller = Value;
		else if (equali(Key, "REVENGE VICTIM MESSAGE")) g_RevengeMsgVictim = Value;
		else if (equali(Key, "TERRO TEAM NAME")) g_FlawlessTName = Value;
		else if (equali(Key, "CT TEAM NAME")) g_FlawlessCTName = Value;
	}

	// CLOSES
	//
	fclose(pFile);
}

// DISPLAYS KILLS STREAK GLOBALLY
//
__Display(Killer, Message[], Sound[])
{
	if (g_bRandomRed) g_Red = random_num(0, QS_MAX8BIT);
	if (g_bRandomGreen) g_Green = random_num(0, QS_MAX8BIT);
	if (g_bRandomBlue) g_Blue = random_num(0, QS_MAX8BIT);

	set_hudmessage(g_Red, g_Green, g_Blue, -1.0, 0.2215, _, _, 5.0);
	qs_ShowSyncHudMsg(0, g_pHudMsg[HUDMSG_KILL], Message, g_Name[Killer]);

	qs_client_cmd(0, "SPK ^"%s^"", Sound);
}

// RETRIEVES PLAYERS COUNT
// bAlive [TRUE/ FALSE]
// Team [QS_INVALIDTEAM/ 1/ 2/ 3]
//
__Players(bool:bAlive, Team = QS_INVALIDTEAM)
{
	// PLAYERS COUNT
	//
	new Total = 0;

	// ITERATES BETWEEN PLAYERS
	//
	for (new Player = 1; Player <= g_maxPlayers; Player++)
	{
		// CONNECTED, NOT HLTV, IN SPECIFIED TEAM AND ALIVE/ DEAD
		//
		if (g_bConnected[Player] && !g_bHLTV[Player] && (Team != QS_INVALIDTEAM && get_user_team(Player) == Team) && \
			bAlive == bool:is_user_alive(Player))
		{
			// TOTAL = TOTAL + 1
			//
			Total++;
		}
	}

	// GETS TOTAL
	//
	return Total;
}

// RETRIEVES THE LEADER OF THIS ROUND
// RETURNS "QS_INVALIDPLR" IF THERE IS NO LEADER
//
__Leader()
{
	// GETS LEADER ID READY
	//
	new Leader = QS_INVALIDPLR;

	// MOST KILLS
	//
	new Kills = 0;

	// ITERATES BETWEEN CLIENTS
	//
	for (new Client = 1; Client <= g_maxPlayers; Client++)
	{
		// CONNECTED AND NOT HLTV
		//
		if (g_bConnected[Client] && !g_bHLTV[Client])
		{
			// HAS MANY KILLS THAN THE ONE PREVIOUSLY CHECKED
			//
			if (g_RKills[Client] > Kills)
			{
				// THIS IS THE NEW LEADER
				//
				Kills = g_RKills[Client];
				Leader = Client;
			}
		}
	}

	// GETS LEADER ID
	//
	return Leader;
}

qs_ShowSyncHudMsg(Target, Object, Rules[], any:...)
{
	static Buffer[256], Player;
	vformat(Buffer, charsmax(Buffer), Rules, 4);

	if (Target != 0 && g_bConnected[Target] && !g_bBOT[Target] && !g_bHLTV[Target] && !g_bDisabled[Target])
		ShowSyncHudMsg(Target, Object, Buffer);

	else
	{
		for (Player = 1; Player <= g_maxPlayers; Player++)
		{
			if (g_bConnected[Player] && !g_bBOT[Player] && !g_bHLTV[Player] && !g_bDisabled[Player])
				ShowSyncHudMsg(Player, Object, Buffer);
		}
	}
}

qs_client_cmd(Target, Rules[], any:...)
{
	static Buffer[256], Player;
	vformat(Buffer, charsmax(Buffer), Rules, 3);

	if (Target != 0 && g_bConnected[Target] && !g_bBOT[Target] && !g_bHLTV[Target] && !g_bDisabled[Target])
		client_cmd(Target, Buffer);

	else
	{
		for (Player = 1; Player <= g_maxPlayers; Player++)
		{
			if (g_bConnected[Player] && !g_bBOT[Player] && !g_bHLTV[Player] && !g_bDisabled[Player])
				client_cmd(Player, Buffer);
		}
	}
}
