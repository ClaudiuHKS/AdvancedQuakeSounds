
/*************************************************************************************
******* PRAGMA ***********************************************************************
*************************************************************************************/

// WHETHER OR NOT TO FORCE ';' AFTER EACH LINE
//
// #pragma semicolon	1

// WHETHER OR NOT TO INCREASE MEMORY FOR THIS SCRIPT
//
#pragma dynamic			524288		// 128 * 128 * 32

// WHETHER OR NOT TO USE '\' AS A CONTROL CHARACTER
// INSTEAD OF THE DEFAULT ONE, WHICH IS '^'
//
// #pragma ctrlchar		'\'

// SETS THE TAB SIZE ('\t' AND ' ') TO 0
// GLOBALLY
//
#pragma tabsize			0

// REQUIRES XSTATS MODULE IF AVAILABLE
//
#pragma reqclass		xstats

// XSTATS DEFAULTS
//
#pragma defclasslib		xstats	csx
#pragma defclasslib		xstats	dodx
#pragma defclasslib		xstats	tfcx
#pragma defclasslib		xstats	tsx


/*************************************************************************************
******* HEADERS **********************************************************************
*************************************************************************************/

// AMX MOD X HEADER FILES
//
#include < amxmodx >
#include < amxmisc >

// FAKE META HEADER FILE
//
#include < fakemeta >


/*************************************************************************************
******* DEFINITIONS ******************************************************************
*************************************************************************************/

// SECONDS DELAY TO SHOW THE INFORMATION MESSAGE REGARDING '/SOUNDS' COMMAND
// AFTER THE PLAYER JOINS THE GAME SERVER
//
#define QS_PLUGIN_INFORMATION_DELAY		( 6.0 )				// 6

// HUD MESSAGE'S MAXIMUM LENGTH
//
#define QS_HUD_MESSAGE_MAX_LENGTH		( 384 )				// 384

// CENTERED HUD MESSAGE'S "X" POSITION
//
#define QS_HUD_MESSAGE_X_POSITION		( -1.0 )			// -1

// HUD MESSAGE'S HOLD TIME (SECONDS TO BE DISPLAYED)
//
#define QS_HUD_MESSAGE_HOLD_TIME		( 5.0 )				// 5

// PLUGIN'S VERSION
//
#define QS_PLUGIN_VERSION				( "5.0" )			// "5"

// INVALID PLAYER
//
#define QS_INVALID_PLAYER				( 0x000000FF )		// 255

// MAXIMUM PLAYERS
//
#define QS_MAX_PLAYERS					( 32 )				// 32

// MAXIMUM BYTE (8 BIT)
//
#define QS_MAX_BYTE						( 0x000000FF )		// 255

// INVALID TEAM
//
#define QS_INVALID_TEAM					( 0x000000FF )		// 255

// [ MONSTER KILL, MULTI KILL, UNSTOPPABLE, .. ] HUD MESSAGE'S "Y" (VERTICAL) POSITION
//
#define QS_STREAK_Y_POSITION			( 0.2215 )			// .2215

// [ SUICIDE, KNIFE, GRENADE, .. ] HUD MESSAGE'S "Y" (VERTICAL) POSITION
//
#define QS_MINOR_EVENTS_Y_POSITION		( 0.2415 )			// .2415

// [ PREPARE TO FIGHT, .. ] HUD MESSAGE'S "Y" (VERTICAL) POSITION
//
#define QS_ROUND_START_Y_POSITION		( 0.2615 )			// .2615

// [ FLAWLESS VICTORY EVENT ] HUD MESSAGE'S "Y" (VERTICAL) POSITION
//
#define QS_FLAWLESS_Y_POSITION			( 0.2815 )			// .2815

// [ HATTRICK ( THE LEADER OF THE ROUND ) ] HUD MESSAGE'S "Y" (VERTICAL) POSITION
//
#define QS_HATTRICK_Y_POSITION			( 0.2015 )			// .2015

// HUD MESSAGE PURPOSES
//
enum /* HUD MESSAGE PURPOSE */
{
	HUDMSG_EVENT = 0,
	HUDMSG_STREAK,
	HUDMSG_ROUND,

	HUDMSG_MAX,
};


/*************************************************************************************
******* GLOBAL VARIABLES *************************************************************
*************************************************************************************/

// PLUG-IN ON/ OFF
//
new bool: g_bPluginEnabled = false;

/**
* HEAD SHOT
*/

// HEAD SHOT ON/ OFF
//
new bool: g_bHShot = false;

// HEAD SHOT MESSAGE ON/ OFF
//
new bool: g_bHShotMsg = false;

// HEAD SHOT MESSAGE
//
new g_HShotMsg [ QS_HUD_MESSAGE_MAX_LENGTH ];

// HEAD SHOT SOUNDS COUNT
//
new g_HShotSize = 0;

// HEAD SHOT ONLY FOR KILLER
//
new bool: g_bHShotOnlyKiller = false;

// HEAD SHOT SOUNDS CONTAINER
//
new Array: g_pHShot = Invalid_Array;

/**
* REVENGE
*/

// REVENGE ON/ OFF
//
new bool: g_bRevenge = false;

// REVENGE MESSAGE FOR KILLER ON/ OFF
//
new bool: g_bRevengeMsgKiller = false;

// REVENGE MESSAGE FOR VICTIM ON/ OFF
//
new bool: g_bRevengeMsgVictim = false;

// REVENGE MESSAGE FOR KILLER (IF ENABLED)
//
new g_RevengeMsgKiller [ QS_HUD_MESSAGE_MAX_LENGTH ];

// REVENGE MESSAGE FOR VICTIM (IF ENABLED)
//
new g_RevengeMsgVictim [ QS_HUD_MESSAGE_MAX_LENGTH ];

// REVENGE SOUNDS COUNT
//
new g_RevengeSize = 0;

// REVENGE ONLY FOR KILER
//
new bool: g_bRevengeOnlyKiller = false;

// REVENGE SOUNDS CONTAINER
//
new Array: g_pRevenge = Invalid_Array;

/**
* HATTRICK
* THE LEADER OF CURRENT ROUND
*/

// HATTRICK ON/ OFF
//
new bool: g_bHattrick = false;

// HATTRICK MESSAGE ON/ OFF
//
new bool: g_bHattrickMsg = false;

// HATTRICK MESSAGE
//
new g_HattrickMsg [ QS_HUD_MESSAGE_MAX_LENGTH ];

// HATTRICK SOUNDS COUNT
//
new g_HattrickSize = 0;

// MINIMUM KILLS REQUIRED FOR HATTRICK
//
new g_MinimumKillsForHattrick = 0;

// HATTRICK SOUNDS CONTAINER
//
new Array: g_pHattrick = Invalid_Array;

/**
* SUICIDE
*/

// SUICIDE ON/ OFF
//
new bool: g_bSuicide = false;

// SUICIDE MESSAGE ON/ OFF
//
new bool: g_bSuicideMsg = false;

// SUICIDE MESSAGE
//
new g_SuicideMsg [ QS_HUD_MESSAGE_MAX_LENGTH ];

// SUICIDE SOUNDS COUNT
//
new g_SuicideSize = 0;

// SUICIDE SOUNDS CONTAINER
//
new Array: g_pSuicide = Invalid_Array;

/**
* GRENADE
*/

// GRENADE ON/ OFF
//
new bool: g_bGrenade = false;

// GRENADE MESSAGE ON/ OFF
//
new bool: g_bGrenadeMsg = false;

// GRENADE KILL MESSAGE
//
new g_GrenadeMsg [ QS_HUD_MESSAGE_MAX_LENGTH ];

// GRENADE SOUNDS COUNT
//
new g_GrenadeSize = 0;

// GRENADE SOUNDS CONTAINER
//
new Array: g_pGrenade = Invalid_Array;

/**
* TEAM KILL
*/

// TEAM KILL ON/ OFF
//
new bool: g_bTKill = false;

// TEAM KILL MESSAGE ON/ OFF
//
new bool: g_bTKillMsg = false;

// TEAM KILL MESSAGE
//
new g_TKillMsg [ QS_HUD_MESSAGE_MAX_LENGTH ];

// TEAM KILL SOUNDS COUNT
//
new g_TKillSize = 0;

// TEAM KILL SOUNDS CONTAINER
//
new Array: g_pTKill = Invalid_Array;

/**
* KNIFE
*/

// KNIFE ON/ OFF
//
new bool: g_bKnife = false;

// KNIFE MESSAGE ON/ OFF
//
new bool: g_bKnifeMsg = false;

// KNIFE KILL MESSAGE
//
new g_KnifeMsg [ QS_HUD_MESSAGE_MAX_LENGTH ];

// KNIFE KILL SOUNDS COUNT
//
new g_KnifeSize = 0;

// KNIFE SOUNDS CONTAINER
//
new Array: g_pKnife = Invalid_Array;

/**
* FIRST BLOOD
*/

// FIRST BLOOD ON/ OFF
//
new bool: g_bFBlood = false;

// FIRST BLOOD MESSAGE ON/ OFF
//
new bool: g_bFBloodMsg = false;

// FIRST BLOOD MESSAGE
//
new g_FBloodMsg [ QS_HUD_MESSAGE_MAX_LENGTH ];

// FIRST BLOOD SOUNDS COUNT
//
new g_FBloodSize = 0;

// FIRST BLOOD VARIABLE
//
new g_FBlood = 0;

// FIRST BLOOD SOUNDS CONTAINER
//
new Array: g_pFBlood = Invalid_Array;

/**
* KILLS STREAK
*/

// KILLS STREAK ON/ OFF
//
new bool: g_bKStreak = false;

// KILL STREAK SOUNDS COUNT
//
new g_KStreakSoundsSize = 0;

// KILLS STREAK SOUNDS CONTAINER
//
new Array: g_pKStreakSounds = Invalid_Array;

// KILLS STREAK MESSAGES CONTAINER
//
new Array: g_pKStreakMessages = Invalid_Array;

// KILLS STREAK REQUIRED KILLS CONTAINER
//
new Array: g_pKStreakRequiredKills = Invalid_Array;

/**
* ROUND START
*/

// ROUND START ON/ OFF
//
new bool: g_bRStart = false;

// ROUND START MESSAGE ON/ OFF
//
new bool: g_bRStartMsg = false;

// ROUND START MESSAGE
//
new g_RStartMsg [ QS_HUD_MESSAGE_MAX_LENGTH ];

// ROUND START SOUNDS COUNT
//
new g_RStartSize = 0;

// ROUND START SOUNDS CONTAINER
//
new Array: g_pRStart = Invalid_Array;

/**
* DOUBLE KILL
*/

// DOUBLE KILL ON/ OFF
//
new bool: g_bDKill = false;

// DOUBLE KILL MESSAGE ON/ OFF
//
new bool: g_bDKillMsg = false;

// DOUBLE KILL MESSAGE
//
new g_DKillMsg [ QS_HUD_MESSAGE_MAX_LENGTH ];

// DOUBLE KILL SOUNDS COUNT
//
new g_DKillSize = 0;

// DOUBLE KILL SOUNDS CONTAINER
//
new Array: g_pDKill = Invalid_Array;

/**
* FLAWLESS
* IF A TEAM KILLS THE OTHER ONE W/ O GETTING ANY CASUALTIES
*/

// FLAWLESS ON/ OFF
//
new bool: g_bFlawless = false;

// FLAWLESS MESSAGE ON/ OFF
//
new bool: g_bFlawlessMsg = false;

// FLAWLESS MESSAGE
//
new g_FlawlessMsg [ QS_HUD_MESSAGE_MAX_LENGTH ];

// FLAWLESS TEAM NAME FOR TEAM [1]
//
new g_FlawlessTeamName_1 [ QS_HUD_MESSAGE_MAX_LENGTH ];

// FLAWLESS TEAM NAME FOR TEAM [2]
//
new g_FlawlessTeamName_2 [ QS_HUD_MESSAGE_MAX_LENGTH ];

// FLAWLESS SOUNDS COUNT
//
new g_FlawlessSize = 0;

// FLAWLESS SOUNDS CONTAINER
//
new Array: g_pFlawless = Invalid_Array;


/**
* HUD MESSAGE [TE_TEXTMESSAGE]
*/

// CHANNEL HANDLES
//
new g_pHudMsg [ HUDMSG_MAX ];

// RED
//
new g_Red = 0;

// RANDOM RED
//
new bool: g_bRandomRed = false;

// GREEN
//
new g_Green = 0;

// RANDOM GREEN
//
new bool: g_bRandomGreen = false;

// BLUE
//
new g_Blue = 0;

// RANDOM BLUE
//
new bool: g_bRandomBlue = false;


/**
* GAME RELATED
*/

// MOD NAME
//
new g_ModName [ 8 ];

// ON DEATHMSG
//
new bool: g_bOnDeathMsg = false;

// DEATHMSG BYTE STATUS
//
new g_DeathMsgByteStatus = 0;

// DEATHMSG ONLY AVAILABLE
//
new bool: g_bDeathMsgOnly = false;

// CACHED KILLER ID
//
new g_Killer = 0;

// CACHED VICTIM ID
//
new g_Victim = 0;

// CACHED WEAPON ID
//
new g_Weapon = 0;

// CACHED HIT PLACE
//
new g_Place = 0;

// CACHED TEAM KILL BOOLEAN
//
new g_TeamKill = 0;


/**
* PLAYERS RELATED
*/

// MAXIMUM PLAYERS
//
new g_MaxPlayers = 0;

// TOTAL KILLS PER PLAYER PER LIFE
// RESETS ON PLAYER DEATH
//
new g_Kills [ QS_MAX_PLAYERS + 1 ];

// TOTAL KILLS PER PLAYER PER ROUND
// RESETS NEXT ROUND
//
new g_KillsThisRound [ QS_MAX_PLAYERS + 1 ];

// HLTV
//
new bool: g_bHLTV [ QS_MAX_PLAYERS + 1 ];

// BOT
//
new bool: g_bBOT [ QS_MAX_PLAYERS + 1 ];

// CONNECTED
//
new bool: g_bConnected [ QS_MAX_PLAYERS + 1 ];

// NAME
//
new g_Name [ QS_MAX_PLAYERS + 1 ] [ 32 ];

// REVENGE KILL NAME STAMP
//
new g_RevengeStamp [ QS_MAX_PLAYERS + 1 ] [ 32 ];

// SOUNDS DISABLED PER PLAYER
//
new bool: g_bDisabled [ QS_MAX_PLAYERS + 1 ];

// LAST KILL TIME STAMP (GAME TIME)
//
new Float: g_fLastKillTimeStamp [ QS_MAX_PLAYERS + 1 ];


/*************************************************************************************
******* FORWARDS *********************************************************************
*************************************************************************************/

// PLUG-IN NATIVES
//
public plugin_natives ( )
{
	// SETS MODULE FILTER
	//
	set_module_filter ( "QS_Module_Filter" );
}

// FILTERS MODULE
//
public QS_Module_Filter ( Module [ ] )
{
	// XSTATS
	//
	if ( equali ( Module, "XStats" ) )
	{
		// LOAD
		//
		return PLUGIN_HANDLED;
	}

	// OK
	//
	return PLUGIN_CONTINUE;
}

// plugin_precache()
// THE RIGHT MOMENT FOR INI FILES
// AND PRECACHING DATA
//
public plugin_precache ( )
{
	// GETS MOD NAME
	//
	QS_CheckMod ( );

	// CREATES ARRAYS FIRST
	//
	g_pHShot =						ArrayCreate ( 256 );
	g_pSuicide =					ArrayCreate ( 256 );
	g_pGrenade =					ArrayCreate ( 256 );
	g_pTKill =						ArrayCreate ( 256 );
	g_pKnife =						ArrayCreate ( 256 );
	g_pFBlood =						ArrayCreate ( 256 );
	g_pRStart =						ArrayCreate ( 256 );
	g_pDKill =						ArrayCreate ( 256 );
	g_pHattrick =					ArrayCreate ( 256 );
	g_pFlawless =					ArrayCreate ( 256 );
	g_pRevenge =					ArrayCreate ( 256 );
	g_pKStreakSounds =				ArrayCreate ( 256 );
	g_pKStreakMessages =			ArrayCreate ( QS_HUD_MESSAGE_MAX_LENGTH );
	g_pKStreakRequiredKills =		ArrayCreate ( 8 );

	// READS FILE
	//
	__Load ( );

	// PRECACHES NOTHING
	// IF PLUG-IN IS OFF
	//
	if ( !g_bPluginEnabled )
		return;

	// RETRIEVES SOUNDS COUNT
	//
	g_HShotSize =					ArraySize ( g_pHShot );
	g_SuicideSize =					ArraySize ( g_pSuicide );
	g_GrenadeSize =					ArraySize ( g_pGrenade );
	g_TKillSize =					ArraySize ( g_pTKill );
	g_KnifeSize =					ArraySize ( g_pKnife );
	g_FBloodSize =					ArraySize ( g_pFBlood );
	g_RStartSize =					ArraySize ( g_pRStart );
	g_DKillSize =					ArraySize ( g_pDKill );
	g_HattrickSize =				ArraySize ( g_pHattrick );
	g_FlawlessSize =				ArraySize ( g_pFlawless );
	g_RevengeSize =					ArraySize ( g_pRevenge );
	g_KStreakSoundsSize =			ArraySize ( g_pKStreakSounds );

	// DEFINES ITERATOR FOR FURTHER USE
	//
	new Iterator = 0;

	// DEFINES SOUND FOR FURTHER USE
	//
	new Sound [ 256 ];

	if ( g_bHShot )
	{
		for ( Iterator = 0; Iterator < g_HShotSize; Iterator ++ )
			ArrayGetString ( g_pHShot, Iterator, Sound, charsmax ( Sound ) ), precache_sound ( Sound );
	}

	if ( g_bSuicide )
	{
		for ( Iterator = 0; Iterator < g_SuicideSize; Iterator ++ )
			ArrayGetString ( g_pSuicide, Iterator, Sound, charsmax ( Sound ) ), precache_sound ( Sound );
	}

	if ( g_bGrenade )
	{
		for ( Iterator = 0; Iterator < g_GrenadeSize; Iterator ++ )
			ArrayGetString ( g_pGrenade, Iterator, Sound, charsmax ( Sound ) ), precache_sound ( Sound );
	}

	if ( g_bTKill )
	{
		for ( Iterator = 0; Iterator < g_TKillSize; Iterator ++ )
			ArrayGetString ( g_pTKill, Iterator, Sound, charsmax ( Sound ) ), precache_sound ( Sound );
	}

	if ( g_bKnife )
	{
		for ( Iterator = 0; Iterator < g_KnifeSize; Iterator ++ )
			ArrayGetString ( g_pKnife, Iterator, Sound, charsmax ( Sound ) ), precache_sound ( Sound );
	}

	if ( g_bFBlood )
	{
		for ( Iterator = 0; Iterator < g_FBloodSize; Iterator ++ )
			ArrayGetString ( g_pFBlood, Iterator, Sound, charsmax ( Sound ) ), precache_sound ( Sound );
	}

	if ( g_bRStart )
	{
		for ( Iterator = 0; Iterator < g_RStartSize; Iterator ++ )
			ArrayGetString ( g_pRStart, Iterator, Sound, charsmax ( Sound ) ), precache_sound ( Sound );
	}

	if ( g_bDKill )
	{
		for ( Iterator = 0; Iterator < g_DKillSize; Iterator ++ )
			ArrayGetString ( g_pDKill, Iterator, Sound, charsmax ( Sound ) ), precache_sound ( Sound );
	}

	if ( g_bHattrick )
	{
		for ( Iterator = 0; Iterator < g_HattrickSize; Iterator ++ )
			ArrayGetString ( g_pHattrick, Iterator, Sound, charsmax ( Sound ) ), precache_sound ( Sound );
	}

	if ( g_bFlawless )
	{
		for ( Iterator = 0; Iterator < g_FlawlessSize; Iterator ++ )
			ArrayGetString ( g_pFlawless, Iterator, Sound, charsmax ( Sound ) ), precache_sound ( Sound );
	}

	if ( g_bRevenge )
	{
		for ( Iterator = 0; Iterator < g_RevengeSize; Iterator ++ )
			ArrayGetString ( g_pRevenge, Iterator, Sound, charsmax ( Sound ) ), precache_sound ( Sound );
	}

	if ( g_bKStreak )
	{
		for ( Iterator = 0; Iterator < g_KStreakSoundsSize; Iterator ++ )
			ArrayGetString ( g_pKStreakSounds, Iterator, Sound, charsmax ( Sound ) ), precache_sound ( Sound );
	}
}

// plugin_end()
// PLUG-IN ENDS
//
public plugin_end ( )
{
	// DESTROYS ARRAYS
	//
	ArrayDestroy ( g_pHShot );
	ArrayDestroy ( g_pSuicide );
	ArrayDestroy ( g_pGrenade );
	ArrayDestroy ( g_pTKill );
	ArrayDestroy ( g_pKnife );
	ArrayDestroy ( g_pFBlood );
	ArrayDestroy ( g_pRStart );
	ArrayDestroy ( g_pDKill );
	ArrayDestroy ( g_pHattrick );
	ArrayDestroy ( g_pFlawless );
	ArrayDestroy ( g_pRevenge );
	ArrayDestroy ( g_pKStreakSounds );
	ArrayDestroy ( g_pKStreakMessages );
	ArrayDestroy ( g_pKStreakRequiredKills );
}

// plugin_init()
// PLUG-IN STARTS
// THE RIGHT MOMENT TO REGISTER STUFF
//
public plugin_init ( )
{
	// GETS MOD NAME
	//
	QS_CheckMod ( );

	// REGISTERS CONSOLE VARIABLE
	//
	new pCVar = register_cvar ( "advanced_quake_sounds",		QS_PLUGIN_VERSION,	( FCVAR_SERVER | FCVAR_EXTDLL | FCVAR_UNLOGGED | FCVAR_SPONLY ) );

	// SETS CONSOLE VARIABLE STRING
	//
	if ( pCVar )
		set_pcvar_string ( pCVar,								QS_PLUGIN_VERSION );

	// STOPS HERE IF THE PLUG-IN IS DISABLED
	//
	if ( !g_bPluginEnabled )
	{
		// REGISTERS PLUG-IN
		//
		register_plugin ( "ADV. QUAKE SOUNDS (DISABLED)",		QS_PLUGIN_VERSION,	"HATTRICK (HTTRCKCLDHKS)" );

		return;
	}

	// REGISTERS PLUG-IN
	//
	register_plugin ( "ADV. QUAKE SOUNDS (ENABLED)",			QS_PLUGIN_VERSION,	"HATTRICK (HTTRCKCLDHKS)" );

	// REGISTERS FAKE META FORWARDS
	//
	register_forward ( FM_MessageBegin,							"OnMessageBegin",	1 );
	register_forward ( FM_WriteByte,							"OnWriteByte",		1 );
	register_forward ( FM_MessageEnd,							"OnMessageEnd",		1 );

	// GETS MAXIMUM PLAYERS
	//
	g_MaxPlayers = get_maxplayers ( );

	// CHECKS WHETHER XSTATS MODULE IS LOADED
	//
	if ( !module_exists ( "xstats" ) )
		g_bDeathMsgOnly = true;

	// COUNTER-STRIKE
	//
	if ( equali ( g_ModName, "CS", 2 ) || \
			equali ( g_ModName, "CZ", 2 ) )
	{
		// ROUND RESTART
		//
		register_event ( "TextMsg", "OnRRestart", "a", "2&#Game_C", "2&#Game_w" );

		// ROUND START
		//
		register_logevent ( "OnRStart",	2,	"1=Round_Start" );

		// ROUND END
		//
		register_logevent ( "OnREnd",	2,	"1=Round_End" );
	}

	// DAY OF DEFEAT
	//
	else if ( equali ( g_ModName, "DOD", 3 ) )
	{
		// ROUND START
		//
		register_event ( "RoundState",	"OnRStart",	"a",	"1=1" );

		// ROUND END
		//
		register_event ( "RoundState",	"OnREnd",	"a",	"1=3",	"1=4" );

		// DISABLES HATTRICK
		//
		g_bHattrick =				false;

		// DISABLES FLAWLESS
		//
		g_bFlawless =				false;
	}

	// NO CS/ CZ OR DOD
	//
	else
	{
		// DISABLES TEAM KILL
		//
		g_bTKill =					false;

		// DISABLES HATTRICK
		//
		g_bHattrick =				false;

		// DISABLES FLAWLESS
		//
		g_bFlawless =				false;

		// DISABLES ROUND START
		//
		g_bRStart =					false;
	}

	// HUD MESSAGE [TE_TEXTMESSAGE] CHANNEL HANDLES
	//
	g_pHudMsg [ HUDMSG_STREAK ] =	CreateHudSyncObj ( );
	g_pHudMsg [ HUDMSG_EVENT ] =	CreateHudSyncObj ( );
	g_pHudMsg [ HUDMSG_ROUND ] =	CreateHudSyncObj ( );
}

// plugin_cfg()
// PLUG-IN EXECUTES THE CONFIGURATION FILES
// THE RIGHT MOMENT TO RE-LOAD THE SETTINGS
//
public plugin_cfg ( )
{
	/**
	* MESSAGES ON/ OFF
	*/

	g_bHShotMsg =			g_HShotMsg [ 0 ] ?			true : false;
	g_bSuicideMsg =			g_SuicideMsg [ 0 ] ?		true : false;
	g_bGrenadeMsg =			g_GrenadeMsg [ 0 ] ?		true : false;
	g_bTKillMsg =			g_TKillMsg [ 0 ] ?			true : false;
	g_bKnifeMsg =			g_KnifeMsg [ 0 ] ?			true : false;
	g_bFBloodMsg =			g_FBloodMsg [ 0 ] ?			true : false;
	g_bRStartMsg =			g_RStartMsg [ 0 ] ?			true : false;
	g_bDKillMsg =			g_DKillMsg [ 0 ] ?			true : false;
	g_bHattrickMsg =		g_HattrickMsg [ 0 ] ?		true : false;
	g_bFlawlessMsg =		g_FlawlessMsg [ 0 ] ?		true : false;
	g_bRevengeMsgVictim =	g_RevengeMsgVictim [ 0 ] ?	true : false;
	g_bRevengeMsgKiller =	g_RevengeMsgKiller [ 0 ] ?	true : false;
}

// client_infochanged ( Player )
// EXECUTES WHEN CLIENT CHANGES INFORMATION
//
public client_infochanged ( Player )
{
	static Name [ 32 ];

	// PLAYER IS CONNECTED AND IT'S NOT A HLTV
	//
	if ( g_bConnected [ Player ] && !g_bHLTV [ Player ] )
	{
		// RETRIEVES NEW NAME (IF ANY)
		//
		get_user_info ( Player, "name", Name, charsmax ( Name ) );

		// UPDATES IF NEEDED
		//
		g_Name [ Player ] = Name;
	}
}

// client_disconnected(Player)
// EXECUTES AFTER CLIENT DISCONNECTS
//
public client_disconnected ( Player )
{
	// NO MORE KILLS
	//
	g_Kills [ Player ] = g_KillsThisRound [ Player ] =												0;

	// NO MORE TRUE DATA
	//
	g_bHLTV [ Player ] = g_bBOT [ Player ] = g_bDisabled [ Player ] = g_bConnected [ Player ] =		false;

	// NO MORE VALID STRINGS
	//
	QS_ClearString																					( g_Name			[ Player ] );
	QS_ClearString																					( g_RevengeStamp	[ Player ] );
}

// client_command(Player)
// EXECUTES WHEN CLIENT TYPES
//
public client_command ( Player )
{
	static Argument [ 16 ];

	// CONNECTED, NOT BOT AND NOT HLTV
	//
	if ( g_bConnected [ Player ] && !g_bBOT [ Player ] && !g_bHLTV [ Player ] )
	{
		// RETRIEVES THE ARGUMENT
		//
		read_argv ( 1, Argument, charsmax ( Argument ) );

		// CHECKS ARGUMENT
		//
		if ( equali ( Argument, "/Sounds", 7 ) || equali ( Argument, "Sounds", 6 ) )
		{
			// ENABLES/ DISABLES SOUNDS PER CLIENT
			//
			client_print ( Player, print_chat, ">> QUAKE SOUNDS HAVE BEEN %s.", g_bDisabled [ Player ] ? "ENABLED" : "DISABLED" );
			g_bDisabled [ Player ] = !g_bDisabled [ Player ];
		}
	}
}

// client_putinserver(Player)
// EXECUTES WHEN CLIENT JOINS
//
public client_putinserver ( Player )
{
	// RETRIEVES PLAYER NAME
	//
	get_user_name ( Player, g_Name [ Player ], charsmax ( g_Name [ ] ) );

	// HLTV
	//
	g_bHLTV [ Player ] =				bool: is_user_hltv ( Player );

	// BOT
	//
	g_bBOT [ Player ] =					bool: is_user_bot ( Player );

	// NO KILLS
	//
	g_Kills [ Player ] =				0;
	g_KillsThisRound [ Player ] =		0;

	// CONNECTED
	//
	g_bConnected [ Player ] =			true;

	// SETTINGS ON
	//
	g_bDisabled [ Player ] =			false;

	// NO REVENGE STAMP YET
	//
	QS_ClearString						( g_RevengeStamp [ Player ] );

	// PRINTS INFORMATION FOR VALID PLAYERS ONLY
	//
	if ( !g_bBOT [ Player ] && !g_bHLTV [ Player ] )
		set_task ( QS_PLUGIN_INFORMATION_DELAY, "QuakeSoundsInfo", Player );
}

// PRINTS INFORMATION TO PLAYER
//
public QuakeSoundsInfo ( Player )
{
	// ONLY IF CONNECTED
	//
	if ( g_bConnected [ Player ] )
		client_print ( Player, print_chat, ">> TYPE 'sounds' TO TURN QUAKE SOUNDS ON OR OFF." );
}

// EXECUTED ON PLAYER DEATH
// THIS IS ONLY REQUIRED FOR CS/ CZ, DOD, TS AND TFC
// THIS IS EXECUTED BEFORE THE DEATH MESSAGE EVENT
//
public client_death ( Killer, Victim, Weapon, Place, TeamKill )
{
	// CACHES WEAPON ID
	//
	g_Weapon =		Weapon;

	// CACHES HIT PLACE
	//
	g_Place =		Place;

	// CACHES TEAM KILL
	//
	g_TeamKill =	TeamKill;
}

// WHEN ROUND RE-STARTS
//
public OnRRestart ( )
{
	static Player;
	for ( Player = 1; Player <= g_MaxPlayers; Player ++ )
	{
		// CLEARS DATA
		//
		g_Kills [ Player ] =				0;
		g_KillsThisRound [ Player ] =		0;

		QS_ClearString						( g_RevengeStamp [ Player ] );
	}
}

// WHEN ROUND STARTS
//
public OnRStart ( )
{
	static Player;

	// RESETS FIRST BLOOD
	//
	if ( g_bFBlood )
		g_FBlood = 0;

	// PREPARES ROUND START EVENT
	//
	if ( g_bRStart )
	{
		if ( g_bRStartMsg )
		{
			if ( g_bRandomRed )		g_Red =		random_num ( 0, QS_MAX_BYTE );
			if ( g_bRandomGreen )	g_Green =	random_num ( 0, QS_MAX_BYTE );
			if ( g_bRandomBlue )	g_Blue =	random_num ( 0, QS_MAX_BYTE );

			set_hudmessage ( g_Red, g_Green, g_Blue, QS_HUD_MESSAGE_X_POSITION, QS_ROUND_START_Y_POSITION, _, _, QS_HUD_MESSAGE_HOLD_TIME );
			QS_ShowHudMsg ( 0, g_pHudMsg [ HUDMSG_ROUND ], g_RStartMsg );
		}

		QS_ClientCommand ( 0, "SPK ^"%a^"", ArrayGetStringHandle ( g_pRStart, random_num ( 0, g_RStartSize - 1 ) ) );
	}

	// RESETS HATTRICK DATA
	//
	if ( g_bHattrick )
	{
		for ( Player = 1; Player <= g_MaxPlayers; Player ++ )
			g_KillsThisRound [ Player ] = 0;
	}
}

// WHEN ROUND ENDS
//
public OnREnd ( )
{
	// GETS HATTRICK READY
	//
	if ( g_bHattrick )	set_task ( 2.8, "__Hattrick" );

	// GETS FLAWLESS READY
	//
	if ( g_bFlawless )	set_task ( 1.2, "__Flawless" );
}

// PREPARES HATTRICK
//
public __Hattrick ( )
{
	// RETRIEVES THE LEADER'S ID
	//
	static Leader;
	Leader = __Leader ( );

	// IF ANY
	//
	if ( Leader != QS_INVALID_PLAYER )
	{
		if ( g_bRandomRed )		g_Red =		random_num ( 0, QS_MAX_BYTE );
		if ( g_bRandomGreen )	g_Green =	random_num ( 0, QS_MAX_BYTE );
		if ( g_bRandomBlue )	g_Blue =	random_num ( 0, QS_MAX_BYTE );

		if ( g_KillsThisRound [ Leader ] >= g_MinimumKillsForHattrick )
		{
			if ( g_bHattrickMsg )
			{
				set_hudmessage ( g_Red, g_Green, g_Blue, QS_HUD_MESSAGE_X_POSITION, QS_HATTRICK_Y_POSITION, _, _, QS_HUD_MESSAGE_HOLD_TIME );
				QS_ShowHudMsg ( 0, g_pHudMsg [ HUDMSG_EVENT ], g_HattrickMsg, g_Name [ Leader ] );
			}

			QS_ClientCommand ( 0, "SPK ^"%a^"", ArrayGetStringHandle ( g_pHattrick, random_num ( 0, g_HattrickSize - 1 ) ) );
		}
	}
}

// PREPARES FLAWLESS
//
public __Flawless ( )
{
	static aliveTeam_1,		aliveTeam_2;
	static allTeam_1,		allTeam_2;

	if ( g_bRandomRed )		g_Red =			random_num ( 0, QS_MAX_BYTE );
	if ( g_bRandomGreen )	g_Green =		random_num ( 0, QS_MAX_BYTE );
	if ( g_bRandomBlue )	g_Blue =		random_num ( 0, QS_MAX_BYTE );

	aliveTeam_1 =			__Players		( true, 1 );
	aliveTeam_2 =			__Players		( true, 2 );

	allTeam_1 =				aliveTeam_1 +	__Players ( false, 1 );
	allTeam_2 =				aliveTeam_2 +	__Players ( false, 2 );

	set_hudmessage ( g_Red, g_Green, g_Blue, QS_HUD_MESSAGE_X_POSITION, QS_FLAWLESS_Y_POSITION, _, _, QS_HUD_MESSAGE_HOLD_TIME );

	if ( allTeam_1 == aliveTeam_1 )
	{
		if ( g_bFlawlessMsg )
			QS_ShowHudMsg ( 0, g_pHudMsg [ HUDMSG_ROUND ], g_FlawlessMsg, g_FlawlessTeamName_1 );

		QS_ClientCommand ( 0, "SPK ^"%a^"", ArrayGetStringHandle ( g_pFlawless, random_num ( 0, g_FlawlessSize - 1 ) ) );
	}

	else if ( allTeam_2 == aliveTeam_2 )
	{
		if ( g_bFlawlessMsg )
			QS_ShowHudMsg ( 0, g_pHudMsg [ HUDMSG_ROUND ], g_FlawlessMsg, g_FlawlessTeamName_2 );

		QS_ClientCommand ( 0, "SPK ^"%a^"", ArrayGetStringHandle ( g_pFlawless, random_num ( 0, g_FlawlessSize - 1 ) ) );
	}
}

// pfnMessageBegin()
// FIRED WHEN A MESSAGE BEGINS
//
public OnMessageBegin ( Destination, Type )
{
	static deathMsg = 0;

	// GETS DEATHMSG ID
	//
	if ( deathMsg == 0 )
		deathMsg = get_user_msgid ( "DeathMsg" );

	// IF GLOBALLY SENT
	//
	if ( deathMsg > 0 && \
			Type == deathMsg && \
				( Destination == MSG_ALL || Destination == MSG_BROADCAST ) )
	{
		g_bOnDeathMsg =			true;
		g_DeathMsgByteStatus =	0;
	}
}

// pfnWriteByte()
// FIRED WHEN A BYTE IS BEING WRITTEN
//
public OnWriteByte ( Byte )
{
	// OUR DEATHMSG
	//
	if ( g_bOnDeathMsg )
	{
		// GETS DATA
		//
		switch ( ++ g_DeathMsgByteStatus )
		{
			case 1: g_Killer =	Byte;
			case 2: g_Victim =	Byte;
		}
	}
}

// pfnMessageEnd()
// FIRED WHEN A MESSAGE ENDS
//
public OnMessageEnd ( )
{
	// OUR DEATHMSG
	//
	if ( g_bOnDeathMsg )
	{
		g_bOnDeathMsg =								false;
		g_DeathMsgByteStatus =						0;

		if ( g_bDeathMsgOnly )
			g_Weapon = g_Place = g_TeamKill =		0;

		// FIRES
		//
		set_task ( 0.0, "__DeathMsg" );
	}
}

// WHEN A PLAYER DIES
// THIS IS EXECUTED AFTER XSTATS MODULE "client_death" FORWARD
//
public __DeathMsg ( )
{
	// DECLARES THE HIT PLACE AND THE WEAPON ID
	//
	static Place, Weapon;

	// SETS THE DECLARED VARIABLES TO ZERO
	//
	Place = Weapon = 0;

	// PREPARES THE WEAPON ID AND THE HIT PLACE
	//
	if ( g_bConnected [ g_Victim ] )
		get_user_attacker ( g_Victim, Weapon, Place );

	// POSSIBLE WEAPON ID FIX
	//
	if ( g_Weapon < 1 )
	{
		if ( Weapon < 1 )
		{
			if ( g_bConnected [ g_Killer ] )
				g_Weapon = get_user_weapon ( g_Killer );
		}

		else
			g_Weapon = Weapon;
	}

	// POSSIBLE HIT PLACE FIX
	//
	if ( g_Place < 1 && Place > 0 )
		g_Place = Place;

	// PREPARES TEAM KILL BOOLEAN IF NEEDED
	//
	if ( g_bDeathMsgOnly && g_bConnected [ g_Killer ] && g_bConnected [ g_Victim ] )
		g_TeamKill = ( get_user_team ( g_Killer ) == get_user_team ( g_Victim ) ) ? 1 : 0;

	// PROCESSES DEATH
	//
	__Death ( g_Killer, g_Victim, g_Weapon, g_Place, g_TeamKill );
}


/*************************************************************************************
******* FUNCTIONS ********************************************************************
*************************************************************************************/

// PROCESSES CLIENT DEATH STUFF FOR ALL MODS
//
__Death ( Killer, Victim, Weapon, Place, TeamKill )
{
	// VARIABLES
	//
	static Iterator = 0, Float: fGameTime = 0.0, WeaponName [ 32 ], Sound [ 256 ], Message [ QS_HUD_MESSAGE_MAX_LENGTH ];

	// RESETS KILLS FOR VICTIM
	//
	if ( g_bKStreak )
		g_Kills [ Victim ] = 0;

	// INVALID KILLER (WORLD)
	//
	if ( !g_bConnected [ Killer ] )
		return;

	// PREPARES HUD MESSAGE COLOR
	//
	if ( g_bRandomRed )		g_Red =		random_num ( 0, QS_MAX_BYTE );
	if ( g_bRandomGreen )	g_Green =	random_num ( 0, QS_MAX_BYTE );
	if ( g_bRandomBlue )	g_Blue =	random_num ( 0, QS_MAX_BYTE );

	// PREPARES HUD MESSAGE
	//
	set_hudmessage ( g_Red, g_Green, g_Blue, QS_HUD_MESSAGE_X_POSITION, QS_MINOR_EVENTS_Y_POSITION, _, _, QS_HUD_MESSAGE_HOLD_TIME );

	// REVENGE KILLER STAMP
	//
	if ( g_bRevenge )
		g_RevengeStamp [ Victim ] = g_Name [ Killer ];

	// SUICIDE
	//
	if ( Victim == Killer )
	{
		if ( g_bSuicide )
		{
			if ( g_bSuicideMsg )
				QS_ShowHudMsg ( 0, g_pHudMsg [ HUDMSG_EVENT ], g_SuicideMsg, g_Name [ Victim ] );

			QS_ClientCommand ( 0, "SPK ^"%a^"", ArrayGetStringHandle ( g_pSuicide, random_num ( 0, g_SuicideSize - 1 ) ) );
		}

		if ( g_bHattrick )
			g_KillsThisRound [ Victim ] --;
	}

	// NORMAL DEATH
	//
	else
	{
		if ( g_bKStreak )
			g_Kills				[ Killer ] ++;

		if ( g_bHattrick )
			g_KillsThisRound	[ Killer ] ++;

		// WEAPON NAME
		//
		if ( Weapon > 0 )
			get_weaponname ( Weapon, WeaponName, charsmax ( WeaponName ) );

		// NO WEAPON
		//
		else
			QS_ClearString ( WeaponName );

		if ( g_bRevenge && equali ( g_Name [ Victim ], g_RevengeStamp [ Killer ] ) )
		{
			QS_ClearString ( g_RevengeStamp [ Killer ] );

			if ( g_bRevengeMsgKiller )
				QS_ShowHudMsg ( Killer, g_pHudMsg [ HUDMSG_EVENT ], g_RevengeMsgKiller, g_Name [ Victim ] );

			if ( g_bRevengeMsgVictim && !g_bRevengeOnlyKiller )
				QS_ShowHudMsg ( Victim, g_pHudMsg [ HUDMSG_EVENT ], g_RevengeMsgVictim, g_Name [ Killer ] );

			QS_ClientCommand ( Killer, "SPK ^"%a^"", ArrayGetStringHandle ( g_pRevenge, random_num ( 0, g_RevengeSize - 1 ) ) );

			if ( !g_bRevengeOnlyKiller )
				QS_ClientCommand ( Victim, "SPK ^"%a^"", ArrayGetStringHandle ( g_pRevenge, random_num ( 0, g_RevengeSize - 1 ) ) );
		}

		if ( g_bHShot && Place == HIT_HEAD )
		{
			if ( g_bHShotMsg )
				QS_ShowHudMsg ( 0, g_pHudMsg [ HUDMSG_EVENT ], g_HShotMsg, g_Name [ Killer ], g_Name [ Victim ] );

			QS_ClientCommand ( g_bHShotOnlyKiller ? Killer : 0, "SPK ^"%a^"", ArrayGetStringHandle ( g_pHShot, random_num ( 0, g_HShotSize - 1 ) ) );
		}

		if ( g_bFBlood && ++ g_FBlood == 1 )
		{
			if ( g_bFBloodMsg )
				QS_ShowHudMsg ( 0, g_pHudMsg [ HUDMSG_EVENT ], g_FBloodMsg, g_Name [ Killer ] );

			QS_ClientCommand ( 0, "SPK ^"%a^"", ArrayGetStringHandle ( g_pFBlood, random_num ( 0, g_FBloodSize - 1 ) ) );
		}

		if ( g_bTKill && TeamKill > 0 )
		{
			if ( g_bTKillMsg )
				QS_ShowHudMsg ( 0, g_pHudMsg [ HUDMSG_EVENT ], g_TKillMsg, g_Name [ Killer ] );

			QS_ClientCommand ( 0, "SPK ^"%a^"", ArrayGetStringHandle ( g_pTKill, random_num ( 0, g_TKillSize - 1 ) ) );
		}

		if ( g_bGrenade && ( containi ( WeaponName, "RECK" ) != -1 || \
								containi ( WeaponName, "ROCK" ) != -1 || \
									containi ( WeaponName, "MK" ) != -1 || \
										containi ( WeaponName, "GRANATE" ) != -1 || \
											containi ( WeaponName, "BOMB" ) != -1 || \
												containi ( WeaponName, "GREN" ) != -1 || \
													containi ( WeaponName, "PIAT" ) != -1 || \
														containi ( WeaponName, "BAZOOKA" ) != -1 || \
															containi ( WeaponName, "PANZER" ) != -1 ) )
		{
			if ( g_bGrenadeMsg )
				QS_ShowHudMsg ( 0, g_pHudMsg [ HUDMSG_EVENT ], g_GrenadeMsg, g_Name [ Killer ], g_Name [ Victim ] );

			QS_ClientCommand ( 0, "SPK ^"%a^"", ArrayGetStringHandle ( g_pGrenade, random_num ( 0, g_GrenadeSize - 1 ) ) );
		}

		if ( g_bKnife && ( containi ( WeaponName, "KNIFE" ) != -1 || \
								containi ( WeaponName, "SPADE" ) != -1 || \
									containi ( WeaponName, "SATCHEL" ) != -1 ) )
		{
			if ( g_bKnifeMsg )
				QS_ShowHudMsg ( 0, g_pHudMsg [ HUDMSG_EVENT ], g_KnifeMsg, g_Name [ Killer ], g_Name [ Victim ] );

			QS_ClientCommand ( 0, "SPK ^"%a^"", ArrayGetStringHandle ( g_pKnife, random_num ( 0, g_KnifeSize - 1 ) ) );
		}

		if ( g_bDKill )
		{
			// GAME TIME
			//
			fGameTime = get_gametime ( );

			if ( g_fLastKillTimeStamp [ Killer ] > fGameTime )
			{
				if ( g_bDKillMsg )
					QS_ShowHudMsg ( 0, g_pHudMsg [ HUDMSG_EVENT ], g_DKillMsg, g_Name [ Killer ], g_Name [ Victim ] );

				QS_ClientCommand ( 0, "SPK ^"%a^"", ArrayGetStringHandle ( g_pDKill, random_num ( 0, g_DKillSize - 1 ) ) );
			}

			g_fLastKillTimeStamp [ Killer ] = fGameTime + 0.1;
		}

		if ( g_bKStreak )
		{
			for ( Iterator = 0; Iterator < g_KStreakSoundsSize; Iterator ++ )
			{
				if ( g_Kills [ Killer ] == ArrayGetCell ( g_pKStreakRequiredKills, Iterator ) )
				{
					ArrayGetString ( g_pKStreakMessages,	Iterator,	Message,	charsmax ( Message ) );
					ArrayGetString ( g_pKStreakSounds,		Iterator,	Sound,		charsmax ( Sound ) );

					__Display ( Killer, Message, Sound );

					break;
				}
			}
		}
	}
}

// LOADS THE FILE
//
__Load ( )
{
	// PREPARES CONFIGURATIONS FILE DIRECTORY
	//
	new File [ 256 ];
	get_configsdir ( File, charsmax ( File ) );

	// APPENDS CONFIGURATIONS FILE NAME
	//
	add ( File, charsmax ( File ), "/quakesounds.ini" );

	// OPENS FILE
	//
	new pFile = fopen ( File, "r" );

	if ( !pFile )
		return;

	// PREPARES FILE LINE
	//
	new Line [ 1024 ], Key [ 256 ], Value [ 768 ], Type [ 512 ], Sound [ 256 ], RequiredKills [ 8 ], Dummy [ 4 ], Message [ QS_HUD_MESSAGE_MAX_LENGTH ];

	// READS FILE
	//
	while ( !feof ( pFile ) )
	{
		// GETS LINE
		//
		fgets ( pFile, Line, charsmax ( Line ) );

		// TRIMS LINE OFF
		//
		trim ( Line );

		// CHECK FOR VALIDITY
		//
		if ( Line [ 0 ] == EOS || \
				Line [ 0 ] == ';' || \
					Line [ 0 ] == '#' || \
						( Line [ 0 ] == '/' && Line [ 1 ] == '/' ) )
		{
			continue;
		}

		// SPLITS STRING IN TOKENS
		//
		strtok ( Line, Key, charsmax ( Key ), Value, charsmax ( Value ), '=' );

		// TRIMS KEY
		//
		trim ( Key );

		// TRIMS VALUE
		//
		trim ( Value );

		//
		// SETTINGS
		//

		if ( equali ( Key, "ENABLE/DISABLE PLUGIN" ) )			g_bPluginEnabled =				bool:	str_to_num ( Value );
		else if ( equali ( Key, "HEADSHOT ONLY KILLER" ) )		g_bHShotOnlyKiller =			bool:	str_to_num ( Value );
		else if ( equali ( Key, "MIN FRAGS FOR HATTRICK" ) )	g_MinimumKillsForHattrick =				str_to_num ( Value );
		else if ( equali ( Key, "REVENGE ONLY FOR KILLER" ) )	g_bRevengeOnlyKiller =			bool:	str_to_num ( Value );

		//
		// HUD MESSAGES
		//

		else if ( equali ( Key, "HUDMSG RED" ) )
		{
			if ( equal ( Value, "_" ) )		g_bRandomRed =		true;
			else g_Red =					str_to_num ( Value );
		}

		else if ( equali ( Key, "HUDMSG GREEN" ) )
		{
			if ( equal ( Value, "_" ) )		g_bRandomGreen =	true;
			else g_Green =					str_to_num ( Value );
		}

		else if ( equali ( Key, "HUDMSG BLUE" ) )
		{
			if ( equal ( Value, "_" ) )		g_bRandomBlue =		true;
			else g_Blue =					str_to_num ( Value );
		}

		// KILLS STREAK SOUNDS
		//
		else if ( equali ( Key, "SOUND" ) )
		{
			parse ( Value, Dummy, charsmax ( Dummy ), Type, charsmax ( Type ) );

			if ( equali ( Type, "REQUIREDKILLS" ) )
			{
				parse ( Value, Dummy, charsmax ( Dummy ), Type, charsmax ( Type ), RequiredKills, \
					charsmax ( RequiredKills ), Dummy, charsmax ( Dummy ), Sound, charsmax ( Sound ) );

				ArrayPushString ( g_pKStreakSounds, Sound );
				ArrayPushCell ( g_pKStreakRequiredKills, str_to_num ( RequiredKills ) );
			}

			else if ( equali ( Type, "MESSAGE" ) )
			{
				strtok ( Value, Type, charsmax ( Type ), Message, charsmax ( Message ), '@' );
				trim ( Message );

				ArrayPushString ( g_pKStreakMessages, Message );
			}
		}

		//
		// EVENTS ON/ OFF
		//

		else if ( equali ( Key, "KILLSTREAK EVENT" ) )		g_bKStreak =		bool: str_to_num ( Value );
		else if ( equali ( Key, "REVENGE EVENT" ) )			g_bRevenge =		bool: str_to_num ( Value );
		else if ( equali ( Key, "HEADSHOT EVENT" ) )		g_bHShot =			bool: str_to_num ( Value );
		else if ( equali ( Key, "SUICIDE EVENT" ) )			g_bSuicide =		bool: str_to_num ( Value );
		else if ( equali ( Key, "NADE EVENT" ) )			g_bGrenade =		bool: str_to_num ( Value );
		else if ( equali ( Key, "TEAMKILL EVENT" ) )		g_bTKill =			bool: str_to_num ( Value );
		else if ( equali ( Key, "KNIFE EVENT" ) )			g_bKnife =			bool: str_to_num ( Value );
		else if ( equali ( Key, "FIRSTBLOOD EVENT" ) )		g_bFBlood =			bool: str_to_num ( Value );
		else if ( equali ( Key, "ROUNDSTART EVENT" ) )		g_bRStart =			bool: str_to_num ( Value );
		else if ( equali ( Key, "DOUBLEKILL EVENT" ) )		g_bDKill =			bool: str_to_num ( Value );
		else if ( equali ( Key, "HATTRICK EVENT" ) )		g_bHattrick =		bool: str_to_num ( Value );
		else if ( equali ( Key, "FLAWLESS VICTORY" ) )		g_bFlawless =		bool: str_to_num ( Value );

		//
		// EVENT SOUNDS
		//

		else if ( equali ( Key, "HEADSHOT SOUNDS" ) )
		{
			while ( Value [ 0 ] != EOS && strtok ( Value, Key, charsmax ( Key ), Value, charsmax ( Value ), ',' ) )
			{
				trim ( Key ), trim ( Value );
				ArrayPushString ( g_pHShot, Key );
			}
		}

		else if ( equali ( Key, "REVENGE SOUNDS" ) )
		{
			while ( Value [ 0 ] != EOS && strtok ( Value, Key, charsmax ( Key ), Value, charsmax ( Value ), ',' ) )
			{
				trim ( Key ), trim ( Value );
				ArrayPushString ( g_pRevenge, Key );
			}
		}

		else if ( equali ( Key, "SUICIDE SOUNDS" ) )
		{
			while ( Value [ 0 ] != EOS && strtok ( Value, Key, charsmax ( Key ), Value, charsmax ( Value ), ',' ) )
			{
				trim ( Key ), trim ( Value );
				ArrayPushString ( g_pSuicide, Key );
			}
		}

		else if ( equali ( Key, "NADE SOUNDS" ) )
		{
			while ( Value [ 0 ] != EOS && strtok ( Value, Key, charsmax ( Key ), Value, charsmax ( Value ), ',' ) )
			{
				trim ( Key ), trim ( Value );
				ArrayPushString ( g_pGrenade, Key );
			}
		}

		else if ( equali ( Key, "TEAMKILL SOUNDS" ) )
		{
			while ( Value [ 0 ] != EOS && strtok ( Value, Key, charsmax ( Key ), Value, charsmax ( Value ), ',' ) )
			{
				trim ( Key ), trim ( Value );
				ArrayPushString ( g_pTKill, Key );
			}
		}

		else if ( equali ( Key, "KNIFE SOUNDS" ) )
		{
			while ( Value [ 0 ] != EOS && strtok ( Value, Key, charsmax ( Key ), Value, charsmax ( Value ), ',' ) )
			{
				trim ( Key ), trim ( Value );
				ArrayPushString ( g_pKnife, Key );
			}
		}

		else if ( equali ( Key, "FIRSTBLOOD SOUNDS" ) )
		{
			while ( Value [ 0 ] != EOS && strtok ( Value, Key, charsmax ( Key ), Value, charsmax ( Value ), ',' ) )
			{
				trim ( Key ), trim ( Value );
				ArrayPushString ( g_pFBlood, Key );
			}
		}

		else if ( equali ( Key, "ROUNDSTART SOUNDS" ) )
		{
			while ( Value [ 0 ] != EOS && strtok ( Value, Key, charsmax ( Key ), Value, charsmax ( Value ), ',' ) )
			{
				trim ( Key ), trim ( Value );
				ArrayPushString ( g_pRStart, Key );
			}
		}

		else if ( equali ( Key, "DOUBLEKILL SOUNDS" ) )
		{
			while ( Value [ 0 ] != EOS && strtok ( Value, Key, charsmax ( Key ), Value, charsmax ( Value ), ',' ) )
			{
				trim ( Key ), trim ( Value );
				ArrayPushString ( g_pDKill, Key );
			}
		}

		else if ( equali ( Key, "HATTRICK SOUNDS" ) )
		{
			while ( Value [ 0 ] != EOS && strtok ( Value, Key, charsmax ( Key ), Value, charsmax ( Value ), ',' ) )
			{
				trim ( Key ), trim ( Value );
				ArrayPushString ( g_pHattrick, Key );
			}
		}

		else if ( equali ( Key, "FLAWLESS SOUNDS" ) )
		{
			while ( Value [ 0 ] != EOS && strtok ( Value, Key, charsmax ( Key ), Value, charsmax ( Value ), ',' ) )
			{
				trim ( Key ), trim ( Value );
				ArrayPushString ( g_pFlawless, Key );
			}
		}

		//
		// MESSAGE STRINGS
		//

		else if ( equali ( Key, "HEADSHOT HUDMSG" ) )			copy ( g_HShotMsg,				charsmax ( g_HShotMsg ),			Value );
		else if ( equali ( Key, "SUICIDE HUDMSG" ) )			copy ( g_SuicideMsg,			charsmax ( g_SuicideMsg ),			Value );
		else if ( equali ( Key, "NADE HUDMSG" ) )				copy ( g_GrenadeMsg,			charsmax ( g_GrenadeMsg ),			Value );
		else if ( equali ( Key, "TEAMKILL HUDMSG" ) )			copy ( g_TKillMsg,				charsmax ( g_TKillMsg ),			Value );
		else if ( equali ( Key, "KNIFE HUDMSG" ) )				copy ( g_KnifeMsg,				charsmax ( g_KnifeMsg ),			Value );
		else if ( equali ( Key, "FIRSTBLOOD HUDMSG" ) )			copy ( g_FBloodMsg,				charsmax ( g_FBloodMsg ),			Value );
		else if ( equali ( Key, "ROUNDSTART HUDMSG" ) )			copy ( g_RStartMsg,				charsmax ( g_RStartMsg ),			Value );
		else if ( equali ( Key, "DOUBLEKILL HUDMSG" ) )			copy ( g_DKillMsg,				charsmax ( g_DKillMsg ),			Value );
		else if ( equali ( Key, "HATTRICK HUDMSG" ) )			copy ( g_HattrickMsg,			charsmax ( g_HattrickMsg ),			Value );
		else if ( equali ( Key, "FLAWLESS VICTORY HUDMSG" ) )	copy ( g_FlawlessMsg,			charsmax ( g_FlawlessMsg ),			Value );
		else if ( equali ( Key, "REVENGE KILLER MESSAGE" ) )	copy ( g_RevengeMsgKiller,		charsmax ( g_RevengeMsgKiller ),	Value );
		else if ( equali ( Key, "REVENGE VICTIM MESSAGE" ) )	copy ( g_RevengeMsgVictim,		charsmax ( g_RevengeMsgVictim ),	Value );
		else if ( equali ( Key, "TERRO TEAM NAME" ) )			copy ( g_FlawlessTeamName_1,	charsmax ( g_FlawlessTeamName_1 ),	Value );
		else if ( equali ( Key, "CT TEAM NAME" ) )				copy ( g_FlawlessTeamName_2,	charsmax ( g_FlawlessTeamName_2 ),	Value );
	}

	// CLOSES
	//
	fclose ( pFile );
}

// DISPLAYS KILLS STREAK GLOBALLY
//
__Display ( Killer, Message [ ], Sound [ ] )
{
	if ( g_bRandomRed )		g_Red =		random_num ( 0, QS_MAX_BYTE );
	if ( g_bRandomGreen )	g_Green =	random_num ( 0, QS_MAX_BYTE );
	if ( g_bRandomBlue )	g_Blue =	random_num ( 0, QS_MAX_BYTE );

	set_hudmessage ( g_Red, g_Green, g_Blue, QS_HUD_MESSAGE_X_POSITION, QS_STREAK_Y_POSITION, _, _, QS_HUD_MESSAGE_HOLD_TIME );
	QS_ShowHudMsg ( 0, g_pHudMsg [ HUDMSG_STREAK ], Message, g_Name [ Killer ] );

	QS_ClientCommand ( 0, "SPK ^"%s^"", Sound );
}

// RETRIEVES PLAYERS COUNT
// bAlive [ TRUE/ FALSE ]
// Team [ QS_INVALID_TEAM / 1 / 2 / 3 ]
//
__Players ( bool: bAlive, Team = QS_INVALID_TEAM )
{
	// PLAYERS COUNT
	//
	static Total, Player;

	// ITERATES BETWEEN PLAYERS
	//
	for ( Total = 0, Player = 1; Player <= g_MaxPlayers; Player ++ )
	{
		// CONNECTED, NOT HLTV, IN SPECIFIED TEAM AND ALIVE/ DEAD
		//
		if ( g_bConnected [ Player ] && !g_bHLTV [ Player ] && \
				( Team != QS_INVALID_TEAM && ( get_user_team ( Player ) == Team ) ) && \
					( bAlive == bool: is_user_alive ( Player ) ) )
		{
			// TOTAL = TOTAL + 1
			//
			Total ++;
		}
	}

	// GETS TOTAL
	//
	return Total;
}

// RETRIEVES THE LEADER OF THIS ROUND
// RETURNS "QS_INVALID_PLAYER" IF THERE IS NO LEADER
//
__Leader ( )
{
	// DECLARES VARIABLES
	//
	static Leader, Kills, Client;

	// ITERATES BETWEEN CLIENTS
	//
	for ( Client = 1, Leader = QS_INVALID_PLAYER, Kills = 0; Client <= g_MaxPlayers; Client ++ )
	{
		// CONNECTED AND NOT HLTV
		//
		if ( g_bConnected [ Client ] && !g_bHLTV [ Client ] )
		{
			// HAS MANY KILLS THAN THE ONE PREVIOUSLY CHECKED
			//
			if ( g_KillsThisRound [ Client ] > Kills )
			{
				// THIS IS THE NEW LEADER
				//
				Kills =		g_KillsThisRound [ Client ];
				Leader =	Client;
			}
		}
	}

	// GETS LEADER ID
	//
	return Leader;
}

// PROCESSES HUD MESSAGE
//
QS_ShowHudMsg ( Target, pObject, Rules [ ], any: ... )
{
	// ARGUMENT FORMAT
	//
	static Buffer [ QS_HUD_MESSAGE_MAX_LENGTH ], Player;
	vformat ( Buffer, charsmax ( Buffer ), Rules, 4 );

	// SPECIFIED CLIENT
	//
	if ( Target > 0 && g_bConnected [ Target ] && !g_bBOT [ Target ] && !g_bHLTV [ Target ] && !g_bDisabled [ Target ] )
		ShowSyncHudMsg ( Target, pObject, Buffer );

	// NO TARGET
	//
	else if ( Target < 1 )
	{
		for ( Player = 1; Player <= g_MaxPlayers; Player ++ )
		{
			if ( g_bConnected [ Player ] && !g_bBOT [ Player ] && !g_bHLTV [ Player ] && !g_bDisabled [ Player ] )
				ShowSyncHudMsg ( Player, pObject, Buffer );
		}
	}
}

// PROCESSES CLIENT COMMAND
//
QS_ClientCommand ( Target, Rules [ ], any: ... )
{
	// ARGUMENT FORMAT
	//
	static Buffer [ 256 ], Player;
	vformat ( Buffer, charsmax ( Buffer ), Rules, 3 );

	// SPECIFIED CLIENT
	//
	if ( Target > 0 && g_bConnected [ Target ] && !g_bBOT [ Target ] && !g_bHLTV [ Target ] && !g_bDisabled [ Target ] )
		client_cmd ( Target, Buffer );

	// NO TARGET
	//
	else if ( Target < 1 )
	{
		for ( Player = 1; Player <= g_MaxPlayers; Player ++ )
		{
			if ( g_bConnected [ Player ] && !g_bBOT [ Player ] && !g_bHLTV [ Player ] && !g_bDisabled [ Player ] )
				client_cmd ( Player, Buffer );
		}
	}
}

// CLEARS STRING
//
QS_ClearString ( String [ ] )
{
	String [ 0 ] = EOS;
}

// CHECKS MOD
//
QS_CheckMod ( )
{
	if ( g_ModName [ 0 ] == EOS )
		get_modname ( g_ModName, charsmax ( g_ModName ) );
}
