
/*************************************************************************************
******* PRAGMA ***********************************************************************
*************************************************************************************/

//
// WHETHER OR NOT TO FORCE ';' AFTER EACH LINE
//
#pragma     semicolon       1

//
// WHETHER OR NOT TO INCREASE MEMORY FOR THIS SCRIPT
//
#pragma     dynamic         4194304     /// B           [[[ INCREASE THIS IF YOU ARE GETTING JUNKY ERROR LOGS ]]]

//
// WHETHER OR NOT TO USE '\' AS A CONTROL CHARACTER
// INSTEAD OF THE DEFAULT ONE, WHICH IS '^'
//
#pragma     ctrlchar        '\'

//
// SETS THE TAB SIZE ( '\t' AND ' ' ) TO 0
// GLOBALLY
//
#pragma     tabsize         0

//
// REQUIRES XSTATS MODULE IF AVAILABLE
//
#pragma     reqclass        xstats

//
// XSTATS DEFAULTS
//
#pragma     defclasslib     xstats      csx
#pragma     defclasslib     xstats      dodx
#pragma     defclasslib     xstats      tfcx
#pragma     defclasslib     xstats      tsx


/*************************************************************************************
******* INCLUDE **********************************************************************
*************************************************************************************/

//
// AMX MOD X HEADER FILE
//
#include    < amxmodx >                 /// plugin_init ( ) +

//
// AMX MOD X CUSTOM HEADER FILE
//
#include    < amxmisc >                 /// get_configsdir ( ) +

//
// FAKE META HEADER FILE
//
#include    < fakemeta >                /// FM_MessageBegin +

//
// HAM SANDWICH HEADER FILE [[[ FOR GAMES WITHOUT "client_death" ( XSTATS ) AND WITHOUT "DeathMsg" ]]]
//
#include    < hamsandwich >             /// Ham_Killed +


/*************************************************************************************
******* DEFINE ***********************************************************************
*************************************************************************************/

//
// PLUGIN'S VERSION
//
#define QS_PLUGIN_VERSION                   ( "6.0" )               /// "6.0"

//
// STARTING WITH '/', THE CONFIG FILE NAME
//
#define QS_CFG_FILE_NAME                    ( "/quakesounds.ini" )  /// "/quakesounds.ini"

//
// THE LOG FILE NAME
//
#define QS_LOG_FILE_NAME                    ( "quakesounds.log" )   /// "quakesounds.log"

//
/// ###################################################################################################
//

//
// CSTRIKE AND CZERO 'TE' TEAM NUMBER
//
#define QS_CSCZ_TEAM_TE                     ( 1 )                   /// 1

//
// CSTRIKE AND CZERO 'CT' TEAM NUMBER
//
#define QS_CSCZ_TEAM_CT                     ( 2 )                   /// 2

//
/// ###################################################################################################
//

//
// SECONDS DELAY TO SHOW THE INFORMATION MESSAGE REGARDING '/SOUNDS' COMMAND
// AFTER THE PLAYER JOINS THE GAME SERVER
//
#define QS_PLUGIN_INFO_DELAY                ( 6.000000 )            /// 6

//
// HATTRICK FEATURE :: ROUND END DELAY
//
#define QS_HATTRICK_ROUND_END_DELAY         ( 2.800000 )            /// 2.8

//
// FLAWLESS VICTORY FEATURE :: ROUND END DELAY
//
#define QS_FLAWLESS_ROUND_END_DELAY         ( 1.200000 )            /// 1.2

//
// THE LAST MAN STANDING FEATURE :: TRIGGER DELAY
//
#define QS_STANDING_TRIGGER_DELAY           ( 1.000000 )            /// 1

//
/// ###################################################################################################
//

//
// INVALID PLAYER
//
#define QS_INVALID_PLAYER                   ( 0x000000FF )          /// 255             [[[ 0x000000FF ]]]

//
// INVALID MESSAGE NUMBER [[[   get_user_msgid ( )  ]]]
//
#define QS_INVALID_MSG                      ( -16384 )              /// -16384

//
// INVALID REQUIRED KILLS [[[   A TRULY HUGE NUMBER     ]]]
//
#define QS_INVALID_REQUIRED_KILLS           ( 0x0FFFFFFF )          /// 268435455       [[[ 0x0FFFFFFF ]]]

//
// INVALID TEAM
//
#define QS_INVALID_TEAM                     ( 0x000000FF )          /// 255             [[[ 0x000000FF ]]]

//
/// ###################################################################################################
//

//
// MAXIMUM PLAYERS
//
#define QS_MAX_PLAYERS                      ( 32 )                  /// 32

//
// EVERYONE ( ALL PLAYERS )
//
#define QS_EVERYONE                         ( 0 )                   /// 0

//
// MAXIMUM BYTE (8 BIT)
//
#define QS_MAX_BYTE                         ( 0x000000FF )          /// 255             [[[ 0x000000FF ]]]

//
/// ###################################################################################################
//

//
// HUD MESSAGE'S MAXIMUM LENGTH
//
#define QS_HUD_MSG_MAX_LEN                  ( 384 )                 /// 384

//
// CENTERED HUD MESSAGE'S "X" POSITION
//
#define QS_HUD_MSG_X_POS                    ( -1.000000 )           /// -1

//
// HUD MESSAGE'S HOLD TIME (SECONDS TO BE DISPLAYED)
//
#define QS_HUD_MSG_HOLD_TIME                ( 5.000000 )            /// 5

//
/// ###################################################################################################
//

//
// [ MONSTER KILL, MULTI KILL, UNSTOPPABLE, .. ] HUD MESSAGE'S "Y" (VERTICAL) POSITION
//
#define QS_STREAK_Y_POS                     ( 0.180000 )            /// .18

// @@@@
/// ### imessage.amxx                       ( 0.200000 )            /// .2
// @@@@

//
// [ SUICIDE, KNIFE, GRENADE, .. ] HUD MESSAGE'S "Y" (VERTICAL) POSITION
//
#define QS_EVENT_Y_POS                      ( 0.220000 )            /// .22

//
// [ REVENGE ] HUD MESSAGE'S "Y" (VERTICAL) POSITION
//
#define QS_REVENGE_Y_POS                    ( 0.240000 )            /// .24

//
// [ THE LAST MAN STANDING ] CSTRIKE AND CZERO HUD MESSAGE'S "Y" (VERTICAL) POSITION
//
#define QS_STANDING_Y_POS                   ( 0.260000 )            /// .26

//
// [ FLAWLESS VICTORY EVENT ] HUD MESSAGE'S "Y" (VERTICAL) POSITION
//
#define QS_FLAWLESS_Y_POS                   ( 0.280000 )            /// .28

//
// [ HATTRICK ( THE LEADER OF THE ROUND ) ] HUD MESSAGE'S "Y" (VERTICAL) POSITION
//
#define QS_HATTRICK_Y_POS                   ( 0.300000 )            /// .3

//
// [ PREPARE TO FIGHT, .. ] HUD MESSAGE'S "Y" (VERTICAL) POSITION
//
#define QS_ROUND_Y_POS                      ( 0.320000 )            /// .32

//
/// ###################################################################################################
//

//
/// HUD MESSAGE PURPOSES
//
enum /** HUD MESSAGE PURPOSE */
{
    QS_HUD_EVENT            =   0   ,   \
    QS_HUD_STREAK           =   1   ,   \
    QS_HUD_HATTRICK         =   2   ,   \
    QS_HUD_ROUND            =   3   ,   \
    QS_HUD_STANDING         =   4   ,   \
    QS_HUD_FLAWLESS         =   5   ,   \
    QS_HUD_REVENGE          =   6   ,   \
    QS_HUD_MAX              =   7   ,
};


/*************************************************************************************
******* GLOBAL VARIABLES *************************************************************
*************************************************************************************/

//
// PLUGIN ON/ OFF
//
static bool: g_bEnabled = false;


/**
 * HEAD SHOT
 */

//
// HEAD SHOT ON/ OFF
//
static bool: g_bHShot = false;

//
// HEAD SHOT MESSAGE ON/ OFF
//
static bool: g_bHShotMsg = false;

//
// HEAD SHOT MESSAGE
//
static g_szHShotMsg [ QS_HUD_MSG_MAX_LEN ];

//
// HEAD SHOT SOUNDS COUNT
//
static g_nHShotSize = 0;

//
// HEAD SHOT ONLY FOR KILLER
//
static bool: g_bHShotOnlyKiller = false;

//
// HEAD SHOT SOUNDS CONTAINER
//
static Array: g_pHShot = Invalid_Array;


/**
 * REVENGE
 */

//
// REVENGE ON/ OFF
//
static bool: g_bRevenge = false;

//
// REVENGE MESSAGE FOR KILLER ON/ OFF
//
static bool: g_bRevengeMsgKiller = false;

//
// REVENGE MESSAGE FOR VICTIM ON/ OFF
//
static bool: g_bRevengeMsgVictim = false;

//
// REVENGE MESSAGE FOR KILLER (IF ENABLED)
//
static g_szRevengeMsgKiller [ QS_HUD_MSG_MAX_LEN ];

//
// REVENGE MESSAGE FOR VICTIM (IF ENABLED)
//
static g_szRevengeMsgVictim [ QS_HUD_MSG_MAX_LEN ];

//
// REVENGE SOUNDS COUNT
//
static g_nRevengeSize = 0;

//
// REVENGE ONLY FOR KILER
//
static bool: g_bRevengeOnlyKiller = false;

//
// REVENGE SOUNDS CONTAINER
//
static Array: g_pRevenge = Invalid_Array;


/**
 * HATTRICK
 *
 * THE LEADER OF THE CURRENT ROUND
 */

//
// HATTRICK ON/ OFF
//
static bool: g_bHattrick = false;

//
// HATTRICK MESSAGE ON/ OFF
//
static bool: g_bHattrickMsg = false;

//
// HATTRICK MESSAGE
//
static g_szHattrickMsg [ QS_HUD_MSG_MAX_LEN ];

//
// HATTRICK SOUNDS COUNT
//
static g_nHattrickSize = 0;

//
// MINIMUM KILLS REQUIRED FOR HATTRICK
//
static g_nMinKillsForHattrick = 0;

//
// DECREASE FRAG IF SUICIDE BY 'KILL' COMMAND
//
static bool: g_bHattrickDecrease = false;

//
// HATTRICK SOUNDS CONTAINER
//
static Array: g_pHattrick = Invalid_Array;


/**
 * THE LAST MAN STANDING
 *
 * CSTRIKE AND CZERO ONLY
 */

//
// THE LAST MAN STANDING ON/ OFF
//
static bool: g_bTLMStanding = false;

//
// THE LAST MAN STANDING TEAM MESSAGE ON/ OFF
//
static bool: g_bTLMStandingTeamMsg = false;

//
// THE LAST MAN STANDING SELF MESSAGE ON/ OFF
//
static bool: g_bTLMStandingSelfMsg = false;

//
// THE LAST MAN STANDING TEAM MESSAGE
//
static g_szTLMStandingTeamMsg [ QS_HUD_MSG_MAX_LEN ];

//
// THE LAST MAN STANDING SELF MESSAGE
//
static g_szTLMStandingSelfMsg [ QS_HUD_MSG_MAX_LEN ];

//
// THE LAST MAN STANDING SOUNDS COUNT
//
static g_nTLMStandingSize = 0;

//
// THE LAST MAN STANDING SOUNDS CONTAINER
//
static Array: g_pTLMStanding = Invalid_Array;

//
// THE LAST MAN STANDING WORDS CONTAINER
//
static Array: g_pTLMStandingWords = Invalid_Array;

//
// THE LAST MAN STANDING WORDS COUNT
//
static g_nTLMStandingWordsSize = 0;

//
// THE LAST MAN STANDING PLAYED THIS ROUND [TE]
//
static bool: g_bTLMStandingDone_TE = false;

//
// THE LAST MAN STANDING PLAYED THIS ROUND [CT]
//
static bool: g_bTLMStandingDone_CT = false;


/**
 * SUICIDE
 */

//
// SUICIDE ON/ OFF
//
static bool: g_bSuicide = false;

//
// SUICIDE MESSAGE ON/ OFF
//
static bool: g_bSuicideMsg = false;

//
// SUICIDE MESSAGE
//
static g_szSuicideMsg [ QS_HUD_MSG_MAX_LEN ];

//
// SUICIDE SOUNDS COUNT
//
static g_nSuicideSize = 0;

//
// SUICIDE SOUNDS CONTAINER
//
static Array: g_pSuicide = Invalid_Array;


/**
 * GRENADE
 */

//
// GRENADE ON/ OFF
//
static bool: g_bGrenade = false;

//
// GRENADE MESSAGE ON/ OFF
//
static bool: g_bGrenadeMsg = false;

//
// GRENADE KILL MESSAGE
//
static g_szGrenadeMsg [ QS_HUD_MSG_MAX_LEN ];

//
// GRENADE SOUNDS COUNT
//
static g_nGrenadeSize = 0;

//
// GRENADE SOUNDS CONTAINER
//
static Array: g_pGrenade = Invalid_Array;


/**
 * TEAM KILL
 */

//
// TEAM KILL ON/ OFF
//
static bool: g_bTKill = false;

//
// TEAM KILL MESSAGE ON/ OFF
//
static bool: g_bTKillMsg = false;

//
// TEAM KILL MESSAGE
//
static g_szTKillMsg [ QS_HUD_MSG_MAX_LEN ];

//
// TEAM KILL SOUNDS COUNT
//
static g_nTKillSize = 0;

//
// TEAM KILL SOUNDS CONTAINER
//
static Array: g_pTKill = Invalid_Array;


/**
 * KNIFE
 */

//
// KNIFE ON/ OFF
//
static bool: g_bKnife = false;

//
// KNIFE MESSAGE ON/ OFF
//
static bool: g_bKnifeMsg = false;

//
// KNIFE KILL MESSAGE
//
static g_szKnifeMsg [ QS_HUD_MSG_MAX_LEN ];

//
// KNIFE KILL SOUNDS COUNT
//
static g_nKnifeSize = 0;

//
// KNIFE SOUNDS CONTAINER
//
static Array: g_pKnife = Invalid_Array;


/**
 * FIRST BLOOD
 */

//
// FIRST BLOOD ON/ OFF
//
static bool: g_bFBlood = false;

//
// FIRST BLOOD MESSAGE ON/ OFF
//
static bool: g_bFBloodMsg = false;

//
// FIRST BLOOD MESSAGE
//
static g_szFBloodMsg [ QS_HUD_MSG_MAX_LEN ];

//
// FIRST BLOOD SOUNDS COUNT
//
static g_nFBloodSize = 0;

//
// FIRST BLOOD VARIABLE
//
static g_nFBlood = 0;

//
// FIRST BLOOD SOUNDS CONTAINER
//
static Array: g_pFBlood = Invalid_Array;


/**
 * KILLS STREAK
 */

//
// KILLS STREAK ON/ OFF
//
static bool: g_bKStreak = false;

//
// KILL STREAK SOUNDS COUNT
//
static g_nKStreakSize = 0;

//
// KILL STREAK REQUIRED KILLS COUNT
//
static g_nKStreakRKillsSize = 0;

//
// KILL STREAK MESSAGES COUNT
//
static g_nKStreakMsgSize = 0;

//
// KILLS STREAK SOUNDS CONTAINER
//
static Array: g_pKStreakSnds = Invalid_Array;

//
// KILLS STREAK MESSAGES CONTAINER
//
static Array: g_pKStreakMsgs = Invalid_Array;

//
// KILLS STREAK REQUIRED KILLS CONTAINER
//
static Array: g_pKStreakReqKills = Invalid_Array;


/**
 * ROUND START
 */

//
// ROUND START ON/ OFF
//
static bool: g_bRStart = false;

//
// ROUND START MESSAGE ON/ OFF
//
static bool: g_bRStartMsg = false;

//
// ROUND START MESSAGE
//
static g_szRStartMsg [ QS_HUD_MSG_MAX_LEN ];

//
// ROUND START SOUNDS COUNT
//
static g_nRStartSize = 0;

//
// ROUND START SOUNDS CONTAINER
//
static Array: g_pRStart = Invalid_Array;


/**
 * DOUBLE KILL
 */

//
// DOUBLE KILL ON/ OFF
//
static bool: g_bDKill = false;

//
// DOUBLE KILL MESSAGE ON/ OFF
//
static bool: g_bDKillMsg = false;

//
// DOUBLE KILL MESSAGE
//
static g_szDKillMsg [ QS_HUD_MSG_MAX_LEN ];

//
// DOUBLE KILL SOUNDS COUNT
//
static g_nDKillSize = 0;

//
// DOUBLE KILL SOUNDS CONTAINER
//
static Array: g_pDKill = Invalid_Array;


/**
 * FLAWLESS
 *
 * IF A TEAM KILLS THE OTHER ONE W/ O GETTING ANY CASUALTIES
 */

//
// FLAWLESS ON/ OFF
//
static bool: g_bFlawless = false;

//
// FLAWLESS MESSAGE ON/ OFF
//
static bool: g_bFlawlessMsg = false;

//
// FLAWLESS MESSAGE
//
static g_szFlawlessMsg [ QS_HUD_MSG_MAX_LEN ];

//
// FLAWLESS TEAM NAME FOR TEAM [1]
//
static g_szFlawlessTeamName_1 [ QS_HUD_MSG_MAX_LEN ];

//
// FLAWLESS TEAM NAME FOR TEAM [2]
//
static g_szFlawlessTeamName_2 [ QS_HUD_MSG_MAX_LEN ];

//
// FLAWLESS SOUNDS COUNT
//
static g_nFlawlessSize = 0;

//
// FLAWLESS SOUNDS CONTAINER
//
static Array: g_pFlawless = Invalid_Array;


/**
 * HUD MESSAGE [ TE_TEXTMESSAGE ]
 */

//
// CHANNEL HANDLES
//
static g_pnHudMsgObj [ QS_HUD_MAX ];

//
// RED
//
static g_nRed = 0;

//
// RANDOM RED
//
static bool: g_bRandomRed = false;

//
// GREEN
//
static g_nGreen = 0;

//
// RANDOM GREEN
//
static bool: g_bRandomGreen = false;

//
// BLUE
//
static g_nBlue = 0;

//
// RANDOM BLUE
//
static bool: g_bRandomBlue = false;


/**
* GAME RELATED
*/

//
// MOD NAME
//
static g_szMod [ 64 ];

//
// MAXIMUM PLAYERS
//
static g_nMaxPlayers = 0;

//
// ON DEATHMSG
//
static bool: g_bOnDeathMsg = false;

//
// DEATHMSG BYTE STATUS
//
static g_nDeathMsgByteStatus = 0;

//
// DEATHMSG ONLY AVAILABLE
//
static bool: g_bDeathMsgOnly = false;

//
// CACHED KILLER ID
//
static g_nKiller = 0;

//
// CACHED VICTIM ID
//
static g_nVictim = 0;

//
// CACHED WEAPON ID
//
static g_nWeapon = 0;

//
// CACHED HIT PLACE
//
static g_nPlace = 0;

//
// CACHED TEAM KILL BOOLEAN
//
static g_nTeamKill = 0;


/**
* PLAYERS RELATED
*/

//
// TOTAL KILLS PER PLAYER PER LIFE
//
// RESETS ON PLAYER DEATH
//
static g_pnKills [ QS_MAX_PLAYERS + 1 ];

//
// TOTAL KILLS PER PLAYER PER ROUND
//
// RESETS NEXT ROUND
//
static g_pnKillsThisRound [ QS_MAX_PLAYERS + 1 ];

//
// HLTV
//
static bool: g_pbHLTV [ QS_MAX_PLAYERS + 1 ];

//
// BOT
//
static bool: g_pbBOT [ QS_MAX_PLAYERS + 1 ];

//
// CONNECTED
//
static bool: g_pbConnected [ QS_MAX_PLAYERS + 1 ];

//
// NAME
//
static g_pszName [ QS_MAX_PLAYERS + 1 ] [ 32 ];

//
// REVENGE KILL NAME STAMP
//
static g_pszRevengeStamp [ QS_MAX_PLAYERS + 1 ] [ 32 ];

//
// REVENGE KILL USER ID STAMP
//
static g_pnRevengeStamp [ QS_MAX_PLAYERS + 1 ];

//
// SOUNDS DISABLED PER PLAYER
//
static bool: g_pbDisabled [ QS_MAX_PLAYERS + 1 ];

//
// CACHED PLAYER'S USER ID
//
static g_pnUserId [ QS_MAX_PLAYERS + 1 ];

//
// LAST KILL TIME STAMP (GAME TIME)
//
static Float: g_pfLastKillTimeStamp [ QS_MAX_PLAYERS + 1 ];


/*************************************************************************************
******* FORWARDS *********************************************************************
*************************************************************************************/

//
// plugin_natives ( )
//
// THE PLUGIN'S NATIVES
//
public plugin_natives ( )
{
    //
    // SETS THE MODULE FILTER
    //
    set_module_filter ( "QS_ModuleFilter" );

    return  PLUGIN_CONTINUE;
}

//
// PERFORMS THE FILTERING
//
public QS_ModuleFilter ( szModule [ ] )
{
    //
    // XSTATS
    //
    if ( equali ( szModule, "XStats" ) )
    {
        //
        // LOAD
        //
        return  PLUGIN_HANDLED;
    }

    //
    // OK
    //
    return  PLUGIN_CONTINUE;
}

//
// plugin_precache ( )
//
// THE RIGHT MOMENT FOR INI FILES
// AND PRECACHING DATA
//
public plugin_precache ( )
{
    //
    // GETS THE MOD NAME
    //
    QS_CheckMod ( );

    //
    // CREATES THE ARRAYS FIRST
    //
    g_pHShot =                      ArrayCreate ( 256 );
    g_pSuicide =                    ArrayCreate ( 256 );
    g_pGrenade =                    ArrayCreate ( 256 );
    g_pTKill =                      ArrayCreate ( 256 );
    g_pKnife =                      ArrayCreate ( 256 );
    g_pFBlood =                     ArrayCreate ( 256 );
    g_pRStart =                     ArrayCreate ( 256 );
    g_pDKill =                      ArrayCreate ( 256 );
    g_pHattrick =                   ArrayCreate ( 256 );

    g_pTLMStanding =                ArrayCreate ( 256 );
    {
        g_pTLMStandingWords =       ArrayCreate ( 64 );
    }

    g_pFlawless =                   ArrayCreate ( 256 );
    g_pRevenge =                    ArrayCreate ( 256 );

    g_pKStreakSnds =                ArrayCreate ( 256 );
    {
        g_pKStreakMsgs =            ArrayCreate ( QS_HUD_MSG_MAX_LEN );
        {
            g_pKStreakReqKills =    ArrayCreate ( 32 );
        }
    }

    //
    // READS THE CONFIGURATION FILE
    //
    QS_LoadSettings ( );

    //
    // PRECACHES NOTHING
    // IF THE PLUGIN IS OFF
    //
    if ( !g_bEnabled )
    {
        return  PLUGIN_CONTINUE;
    }

    //
    // RETRIEVES SOUNDS COUNT
    //
    g_nHShotSize =                  ArraySize ( g_pHShot );
    g_nSuicideSize =                ArraySize ( g_pSuicide );
    g_nGrenadeSize =                ArraySize ( g_pGrenade );
    g_nTKillSize =                  ArraySize ( g_pTKill );
    g_nKnifeSize =                  ArraySize ( g_pKnife );
    g_nFBloodSize =                 ArraySize ( g_pFBlood );
    g_nRStartSize =                 ArraySize ( g_pRStart );
    g_nDKillSize =                  ArraySize ( g_pDKill );
    g_nHattrickSize =               ArraySize ( g_pHattrick );
    g_nTLMStandingSize =            ArraySize ( g_pTLMStanding );
    g_nTLMStandingWordsSize =       ArraySize ( g_pTLMStandingWords );
    g_nFlawlessSize =               ArraySize ( g_pFlawless );
    g_nRevengeSize =                ArraySize ( g_pRevenge );
    g_nKStreakSize =                ArraySize ( g_pKStreakSnds );
    g_nKStreakRKillsSize =          ArraySize ( g_pKStreakReqKills );
    g_nKStreakMsgSize =             ArraySize ( g_pKStreakMsgs );

    //
    // SANITY CHECK
    //
    if ( g_nKStreakSize > g_nKStreakMsgSize || g_nKStreakSize < g_nKStreakMsgSize || \
            g_nKStreakSize > g_nKStreakRKillsSize || g_nKStreakSize < g_nKStreakRKillsSize || \
                g_nKStreakMsgSize > g_nKStreakSize || g_nKStreakMsgSize < g_nKStreakSize || \
                    g_nKStreakMsgSize > g_nKStreakRKillsSize || g_nKStreakMsgSize < g_nKStreakRKillsSize || \
                        g_nKStreakRKillsSize > g_nKStreakSize || g_nKStreakRKillsSize < g_nKStreakSize || \
                            g_nKStreakRKillsSize > g_nKStreakMsgSize || g_nKStreakRKillsSize < g_nKStreakMsgSize )
    {
        log_to_file     ( QS_LOG_FILE_NAME, "****************************************************************************************************************" );
        log_to_file     ( QS_LOG_FILE_NAME, "K. Streak Items (Multi Kill, Triple Kill, Rampage, ..) Will Be Disabled." );
        log_to_file     ( QS_LOG_FILE_NAME, "Inside The Configuration File, You Should Have Same 'REQUIREDKILLS' And 'MESSAGE @'.");
        log_to_file     ( QS_LOG_FILE_NAME, "For Example, If You Have 8 Pieces Of 'REQUIREDKILLS', You Should Have 8 Pieces Of 'MESSAGE @' As Well.");

        g_bKStreak =    false;
    }

    //
    // DEFINES ITERATOR FOR FURTHER USE
    //
    new nIter = 0;

    //
    // DEFINES SOUND FOR FURTHER USE
    //
    new szSnd [ 256 ];

    if ( g_bHShot )
    {
        for ( nIter = 0; nIter < g_nHShotSize; nIter ++ )
        {
            ArrayGetString ( g_pHShot, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    if ( g_bSuicide )
    {
        for ( nIter = 0; nIter < g_nSuicideSize; nIter ++ )
        {
            ArrayGetString ( g_pSuicide, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    if ( g_bGrenade )
    {
        for ( nIter = 0; nIter < g_nGrenadeSize; nIter ++ )
        {
            ArrayGetString ( g_pGrenade, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    if ( g_bTKill )
    {
        for ( nIter = 0; nIter < g_nTKillSize; nIter ++ )
        {
            ArrayGetString ( g_pTKill, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    if ( g_bKnife )
    {
        for ( nIter = 0; nIter < g_nKnifeSize; nIter ++ )
        {
            ArrayGetString ( g_pKnife, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    if ( g_bFBlood )
    {
        for ( nIter = 0; nIter < g_nFBloodSize; nIter ++ )
        {
            ArrayGetString ( g_pFBlood, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    if ( g_bRStart )
    {
        for ( nIter = 0; nIter < g_nRStartSize; nIter ++ )
        {
            ArrayGetString ( g_pRStart, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    if ( g_bDKill )
    {
        for ( nIter = 0; nIter < g_nDKillSize; nIter ++ )
        {
            ArrayGetString ( g_pDKill, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    if ( g_bHattrick )
    {
        for ( nIter = 0; nIter < g_nHattrickSize; nIter ++ )
        {
            ArrayGetString ( g_pHattrick, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    if ( g_bTLMStanding )
    {
        for ( nIter = 0; nIter < g_nTLMStandingSize; nIter ++ )
        {
            ArrayGetString ( g_pTLMStanding, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    if ( g_bFlawless )
    {
        for ( nIter = 0; nIter < g_nFlawlessSize; nIter ++ )
        {
            ArrayGetString ( g_pFlawless, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    if ( g_bRevenge )
    {
        for ( nIter = 0; nIter < g_nRevengeSize; nIter ++ )
        {
            ArrayGetString ( g_pRevenge, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    if ( g_bKStreak )
    {
        for ( nIter = 0; nIter < g_nKStreakSize; nIter ++ )
        {
            ArrayGetString ( g_pKStreakSnds, nIter, szSnd, charsmax ( szSnd ) );

            if ( !QS_EmptyString ( szSnd ) )
            {
                precache_sound ( szSnd );
            }
        }
    }

    copy ( g_pszName [ 0 ], charsmax ( g_pszName [ ] ), "WORLDSPAWN" );

    return  PLUGIN_CONTINUE;
}

//
// plugin_end ( )
//
// THE PLUGIN ENDS
//
public plugin_end ( )
{
    //
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
    ArrayDestroy ( g_pTLMStanding );
    ArrayDestroy ( g_pTLMStandingWords );
    ArrayDestroy ( g_pFlawless );
    ArrayDestroy ( g_pRevenge );
    ArrayDestroy ( g_pKStreakSnds );
    ArrayDestroy ( g_pKStreakMsgs );
    ArrayDestroy ( g_pKStreakReqKills );

    return  PLUGIN_CONTINUE;
}

//
// plugin_init ( )
//
// THE PLUGIN STARTS
// THE RIGHT MOMENT TO REGISTER STUFF
//
public plugin_init ( )
{
    //
    // GETS THE MOD NAME
    //
    QS_CheckMod ( );

    //
    // REGISTERS THE PLUGIN'S CONSOLE VARIABLE
    //
    new pCVar = register_cvar ( "advanced_quake_sounds",        QS_PLUGIN_VERSION,      FCVAR_SERVER | FCVAR_SPONLY );

    //
    // SETS THE CONSOLE VARIABLE STRING
    //
    if ( pCVar )
    {
        set_pcvar_string ( pCVar,                               QS_PLUGIN_VERSION );
    }

    //
    // STOPS HERE IF THE PLUGIN IS DISABLED
    //
    if ( !g_bEnabled )
    {
        //
        // REGISTERS THE PLUGIN
        //
        register_plugin ( "ADV. QUAKE SOUNDS (DISABLED)",       QS_PLUGIN_VERSION,      "HATTRICK (HTTRCKCLDHKS)" );

        return  PLUGIN_CONTINUE;
    }

    //
    // REGISTERS THE PLUGIN
    //
    register_plugin ( "ADV. QUAKE SOUNDS (ENABLED)",            QS_PLUGIN_VERSION,      "HATTRICK (HTTRCKCLDHKS)" );

    //
    // REGISTERS THE FAKE META FORWARDS
    //
    register_forward ( FM_MessageBegin,                         "QS_FM_OnMsgBegin",     1 );
    register_forward ( FM_WriteByte,                            "QS_FM_OnWriteByte",    1 );
    register_forward ( FM_MessageEnd,                           "QS_FM_OnMsgEnd",       1 );

    //
    // GETS THE MAXIMUM PLAYERS
    //
    g_nMaxPlayers =         get_maxplayers ( );

    //
    // CHECKS WHETHER XSTATS MODULE IS LOADED
    //
    g_bDeathMsgOnly =       !QS_XStatsAvail ( );

    //
    // CSTRIKE OR CZERO
    //
    if ( QS_CSCZRunning ( ) )
    {
        //
        // ROUND RESTART
        //
        register_event ( "TextMsg",             "QS_OnRoundRefresh",    "a",                    "2&#Game_C",        "2&#Game_w" );

        //
        // ROUND START
        //
        register_logevent ( "QS_OnRoundBegin",  2,                      "1=Round_Start" );

        //
        // ROUND END
        //
        register_logevent ( "QS_OnRoundEnd",    2,                      "1=Round_End" );
    }

    //
    // DAY OF DEFEAT
    //
    else if ( QS_DODRunning ( ) )
    {
        //
        // ROUND START
        //
        register_event ( "RoundState",          "QS_OnRoundBegin",      "a",                    "1=1" );

        //
        // ROUND END
        //
        register_event ( "RoundState",          "QS_OnRoundEnd",        "a",                    "1=3",              "1=4" );

        //
        // DISABLES HATTRICK
        //
        g_bHattrick =                           false;

        //
        // DISABLES FLAWLESS
        //
        g_bFlawless =                           false;

        //
        // DISABLES THE LAST MAN STANDING
        //
        g_bTLMStanding =                        false;
    }

    //
    // NO CS/ CZ OR DOD
    //
    else
    {
        //
        // DISABLES TEAM KILL
        //
        g_bTKill =                              false;

        //
        // DISABLES HATTRICK
        //
        g_bHattrick =                           false;

        //
        // DISABLES FLAWLESS
        //
        g_bFlawless =                           false;

        //
        // DISABLES ROUND START
        //
        g_bRStart =                             false;

        //
        // DISABLES THE LAST MAN STANDING
        //
        g_bTLMStanding =                        false;

        //
        // GAMES WITHOUT "client_death" ( XSTATS ) AND WITHOUT "DeathMsg"
        //
        if ( g_bDeathMsgOnly )
        {
            RegisterHam ( Ham_Killed, "player", "QS_HAM_PlayerKilled" );
        }
    }

    //
    // HUD MESSAGE [ TE_TEXTMESSAGE ] CHANNEL HANDLES
    //
    g_pnHudMsgObj [ QS_HUD_STREAK   ]   =   CreateHudSyncObj ( );
    g_pnHudMsgObj [ QS_HUD_EVENT    ]   =   CreateHudSyncObj ( );
    g_pnHudMsgObj [ QS_HUD_ROUND    ]   =   CreateHudSyncObj ( );
    g_pnHudMsgObj [ QS_HUD_FLAWLESS ]   =   CreateHudSyncObj ( );
    g_pnHudMsgObj [ QS_HUD_STANDING ]   =   CreateHudSyncObj ( );
    g_pnHudMsgObj [ QS_HUD_HATTRICK ]   =   CreateHudSyncObj ( );
    g_pnHudMsgObj [ QS_HUD_REVENGE  ]   =   CreateHudSyncObj ( );

    return  PLUGIN_CONTINUE;
}

//
// GAMES WITHOUT "client_death" ( XSTATS ) AND WITHOUT "DeathMsg"
//
public QS_HAM_PlayerKilled ( nVictim )
{
    static nWeapon =                                    0;

    static nDeathMsg =                                  QS_INVALID_MSG;

    static bool: bChecked =                             false;

    if ( !QS_IsPlayer ( nVictim ) ||                    !g_pbConnected [ nVictim ] )
    {
        return  PLUGIN_CONTINUE;
    }

    if ( !bChecked )
    {
        bChecked =                                      true;

        nDeathMsg =                                     get_user_msgid ( "DeathMsg" );
    }

    if ( nDeathMsg < 1 )
    {
        g_nVictim =                                     nVictim;

        g_nWeapon = g_nPlace = g_nTeamKill =            0;

        g_nKiller =                                     get_user_attacker ( g_nVictim, g_nWeapon, g_nPlace );

        if ( QS_IsPlayer ( g_nKiller ) &&               g_pbConnected [ g_nKiller ] )
        {
            if ( g_nWeapon < 1 )
            {
                nWeapon =                               get_user_weapon ( g_nKiller );

                if ( nWeapon > 0 )
                {
                    g_nWeapon =                         nWeapon;
                }
            }

            g_nTeamKill =                               ( get_user_team ( g_nKiller ) == get_user_team ( g_nVictim ) ) ? 1 : 0;

            set_task                                    ( 0.0, "QS_ProcessDeathMsg" );
        }

        else
        {
            g_nWeapon = g_nPlace = g_nTeamKill =        0;
        }
    }

    return  PLUGIN_CONTINUE;
}

//
// plugin_cfg ( )
//
// THE PLUGIN EXECUTES THE CONFIGURATION FILES
// THE RIGHT MOMENT TO RELOAD THE SETTINGS
//
public plugin_cfg ( )
{
    /**
     * MESSAGES ON/ OFF
     */

    g_bHShotMsg =                   !QS_EmptyString ( g_szHShotMsg );
    g_bSuicideMsg =                 !QS_EmptyString ( g_szSuicideMsg );
    g_bGrenadeMsg =                 !QS_EmptyString ( g_szGrenadeMsg );
    g_bTKillMsg =                   !QS_EmptyString ( g_szTKillMsg );
    g_bKnifeMsg =                   !QS_EmptyString ( g_szKnifeMsg );
    g_bFBloodMsg =                  !QS_EmptyString ( g_szFBloodMsg );
    g_bRStartMsg =                  !QS_EmptyString ( g_szRStartMsg );
    g_bDKillMsg =                   !QS_EmptyString ( g_szDKillMsg );
    g_bHattrickMsg =                !QS_EmptyString ( g_szHattrickMsg );
    g_bTLMStandingTeamMsg =         !QS_EmptyString ( g_szTLMStandingTeamMsg );
    g_bTLMStandingSelfMsg =         !QS_EmptyString ( g_szTLMStandingSelfMsg );
    g_bFlawlessMsg =                !QS_EmptyString ( g_szFlawlessMsg );
    g_bRevengeMsgVictim =           !QS_EmptyString ( g_szRevengeMsgVictim );
    g_bRevengeMsgKiller =           !QS_EmptyString ( g_szRevengeMsgKiller );

    return  PLUGIN_CONTINUE;
}

//
// client_infochanged ( nPlayer )
//
// EXECUTES WHEN THE CLIENT CHANGES INFORMATION
//
public client_infochanged ( nPlayer )
{
    static szName [ 32 ];

    //
    // PLAYER IS CONNECTED AND IT'S NOT A HLTV
    //
    if ( g_pbConnected [ nPlayer ] && !g_pbHLTV [ nPlayer ] )
    {
        //
        // RETRIEVES NEW NAME (IF ANY)
        //
        get_user_info ( nPlayer, "name", szName, charsmax ( szName ) );

        //
        // UPDATES IF NEEDED
        //
        g_pszName [ nPlayer ] = szName;
    }

    return  PLUGIN_CONTINUE;
}

//
// client_disconnected ( nPlayer )
//
// EXECUTES AFTER THE CLIENT DISCONNECTS
//
public client_disconnected ( nPlayer )
{
    //
    // NO MORE KILLS AND STAMPS
    //
    g_pnKills [ nPlayer ] = g_pnKillsThisRound [ nPlayer ] = g_pnRevengeStamp [ nPlayer ] = g_pnUserId [ nPlayer ] =    0;

    //
    // NO MORE TRUE DATA
    //
    g_pbHLTV [ nPlayer ] = g_pbBOT [ nPlayer ] = g_pbDisabled [ nPlayer ] = g_pbConnected [ nPlayer ] =                 false;

    //
    // NO MORE VALID STRINGS
    //
    QS_ClearString  ( g_pszName             [ nPlayer ] );
    QS_ClearString  ( g_pszRevengeStamp     [ nPlayer ] );

    return  PLUGIN_CONTINUE;
}

//
// client_command ( nPlayer )
//
// EXECUTES WHEN THE CLIENT TYPES
//
public client_command ( nPlayer )
{
    static szArg [ 16 ];

    //
    // CONNECTED, NOT BOT AND NOT HLTV
    //
    if ( g_pbConnected [ nPlayer ]  &&  !g_pbBOT [ nPlayer ]    &&  !g_pbHLTV [ nPlayer ] )
    {
        //
        // RETRIEVES THE ARGUMENT
        //
        read_argv ( 1, szArg, charsmax ( szArg ) );

        //
        // CHECKS ARGUMENT
        //
        if ( equali ( szArg, ".Sounds", 7 ) || \
                equali ( szArg, "/Sounds", 7 ) || \
                    equali ( szArg, "Sounds", 6 ) )
        {
            //
            // ENABLES/ DISABLES SOUNDS PER CLIENT
            //
            client_print    ( nPlayer, print_chat, ">> QUAKE SOUNDS HAVE BEEN %s.", g_pbDisabled [ nPlayer ] ? "ENABLED" : "DISABLED" );

            g_pbDisabled    [ nPlayer ]     =   !g_pbDisabled   [ nPlayer ];
        }
    }

    return  PLUGIN_CONTINUE;
}

//
// client_putinserver ( nPlayer )
//
// EXECUTES WHEN CLIENT JOINS
//
public client_putinserver ( nPlayer )
{
    //
    // RETRIEVES PLAYER NAME
    //
    get_user_name ( nPlayer, g_pszName [ nPlayer ], charsmax ( g_pszName [ ] ) );

    //
    // HLTV
    //
    g_pbHLTV [ nPlayer ] =                  bool: is_user_hltv ( nPlayer );

    //
    // BOT
    //
    g_pbBOT [ nPlayer ] =                   bool: is_user_bot ( nPlayer );

    //
    // NO KILLS
    //
    g_pnKills [ nPlayer ] =                 0;
    g_pnKillsThisRound [ nPlayer ] =        0;

    //
    // CONNECTED
    //
    g_pbConnected [ nPlayer ] =             true;

    //
    // USER ID
    //
    g_pnUserId [ nPlayer ] =                get_user_userid ( nPlayer );

    //
    // SETTINGS ON
    //
    g_pbDisabled [ nPlayer ] =              false;

    //
    // NO REVENGE STAMP YET
    //
    QS_ClearString                          ( g_pszRevengeStamp [ nPlayer ] );

    g_pnRevengeStamp [ nPlayer ] =          0;

    //
    // PRINTS INFORMATION FOR VALID PLAYERS ONLY
    //
    if ( !g_pbBOT [ nPlayer ] && !g_pbHLTV [ nPlayer ] )
    {
        set_task ( QS_PLUGIN_INFO_DELAY, "QS_DisplayPlayerInfo", nPlayer );
    }

    return  PLUGIN_CONTINUE;
}

//
// PRINTS INFORMATION TO PLAYER
//
public QS_DisplayPlayerInfo ( nPlayer )
{
    //
    // ONLY IF CONNECTED
    //
    if ( g_pbConnected [ nPlayer ] )
    {
        client_print ( nPlayer, print_chat, ">> TYPE 'sounds' TO TURN QUAKE SOUNDS ON OR OFF." );
    }

    return  PLUGIN_CONTINUE;
}

//
// EXECUTED ON PLAYER DEATH
//
// THIS IS ONLY REQUIRED FOR CS/ CZ, DOD, TS AND TFC
// THIS IS EXECUTED BEFORE THE DEATH MESSAGE EVENT
//
public client_death ( nKiller, nVictim, nWeapon, nPlace, nTeamKill )
{
    //
    // CACHES WEAPON ID
    //
    g_nWeapon =     nWeapon;

    //
    // CACHES HIT PLACE
    //
    g_nPlace =      nPlace;

    //
    // CACHES TEAM KILL
    //
    g_nTeamKill =   nTeamKill;

    //
    // THE LAST MAN STANDING PREPARATION
    //
    if ( g_bTLMStanding )
    {
        set_task ( QS_STANDING_TRIGGER_DELAY,   "QS_PrepareManStanding" );
    }

    return  PLUGIN_CONTINUE;
}

//
// PREPARES THE LAST MAN STANDING
//
public QS_PrepareManStanding ( )
{
    if ( g_bTLMStanding && ( QS_GetTeamTotalAlive ( QS_CSCZ_TEAM_TE ) == 1 || QS_GetTeamTotalAlive ( QS_CSCZ_TEAM_CT ) == 1 ) )
    {
        set_task ( 0.0, "QS_PerformManStanding" );
    }

    return  PLUGIN_CONTINUE;
}

//
// PERFORMS THE LAST MAN STANDING
//
public QS_PerformManStanding ( )
{
    static nPlayer = 0, nTEGuy = 0, nTEs = 0, nCTGuy = 0, nCTs = 0;

    nTEs =  QS_GetTeamTotalAlive ( QS_CSCZ_TEAM_TE, nTEGuy );
    nCTs =  QS_GetTeamTotalAlive ( QS_CSCZ_TEAM_CT, nCTGuy );

    if ( g_bTLMStandingDone_TE == false && nTEs == 1 && nCTs > 0 )
    {
        g_bTLMStandingDone_TE = true;

        if ( !g_pbDisabled [ nTEGuy ] )
        {
            QS_ClientCmd ( nTEGuy, "SPK \"%a\"", ArrayGetStringHandle ( g_pTLMStanding, random_num ( 0, g_nTLMStandingSize - 1 ) ) );
        }

        QS_UpdateHudMsgColor ( );

        set_hudmessage ( g_nRed, g_nGreen, g_nBlue, QS_HUD_MSG_X_POS, QS_STANDING_Y_POS, _, _, QS_HUD_MSG_HOLD_TIME );

        for ( nPlayer = 1; nPlayer <= g_nMaxPlayers; nPlayer ++ )
        {
            if ( g_pbDisabled [ nPlayer ] || \
                    !g_pbConnected [ nPlayer ] || \
                        g_pbBOT [ nPlayer ] || \
                            g_pbHLTV [ nPlayer ] || \
                                get_user_team ( nPlayer ) != QS_CSCZ_TEAM_TE )
            {
                continue;
            }

            if ( nPlayer == nTEGuy )
            {
                if ( g_bTLMStandingSelfMsg )
                {
                    QS_ShowHudMsg ( nTEGuy, g_pnHudMsgObj [ QS_HUD_STANDING ], g_szTLMStandingSelfMsg, \
                                        ArrayGetStringHandle ( g_pTLMStandingWords, random_num ( 0, g_nTLMStandingWordsSize - 1 ) ) );
                }
            }

            else
            {
                if ( g_bTLMStandingTeamMsg )
                {
                    QS_ShowHudMsg ( nPlayer, g_pnHudMsgObj [ QS_HUD_STANDING ], g_szTLMStandingTeamMsg, \
                                        g_pszName [ nTEGuy ], \
                                            ArrayGetStringHandle ( g_pTLMStandingWords, random_num ( 0, g_nTLMStandingWordsSize - 1 ) ) );
                }
            }
        }
    }

    else if ( g_bTLMStandingDone_CT == false && nCTs == 1 && nTEs > 0 )
    {
        g_bTLMStandingDone_CT = true;

        if ( !g_pbDisabled [ nCTGuy ] )
        {
            QS_ClientCmd ( nCTGuy, "SPK \"%a\"", ArrayGetStringHandle ( g_pTLMStanding, random_num ( 0, g_nTLMStandingSize - 1 ) ) );
        }

        QS_UpdateHudMsgColor ( );

        set_hudmessage ( g_nRed, g_nGreen, g_nBlue, QS_HUD_MSG_X_POS, QS_STANDING_Y_POS, _, _, QS_HUD_MSG_HOLD_TIME );

        for ( nPlayer = 1; nPlayer <= g_nMaxPlayers; nPlayer ++ )
        {
            if ( g_pbDisabled [ nPlayer ] || \
                    !g_pbConnected [ nPlayer ] || \
                        g_pbBOT [ nPlayer ] || \
                            g_pbHLTV [ nPlayer ] || \
                                get_user_team ( nPlayer ) != QS_CSCZ_TEAM_CT )
            {
                continue;
            }

            if ( nPlayer == nCTGuy )
            {
                if ( g_bTLMStandingSelfMsg )
                {
                    QS_ShowHudMsg ( nCTGuy, g_pnHudMsgObj [ QS_HUD_STANDING ], g_szTLMStandingSelfMsg, \
                                        ArrayGetStringHandle ( g_pTLMStandingWords, random_num ( 0, g_nTLMStandingWordsSize - 1 ) ) );
                }
            }

            else
            {
                if ( g_bTLMStandingTeamMsg )
                {
                    QS_ShowHudMsg ( nPlayer, g_pnHudMsgObj [ QS_HUD_STANDING ], g_szTLMStandingTeamMsg, \
                                        g_pszName [ nCTGuy ], \
                                            ArrayGetStringHandle ( g_pTLMStandingWords, random_num ( 0, g_nTLMStandingWordsSize - 1 ) ) );
                }
            }
        }
    }

    return  PLUGIN_CONTINUE;
}

//
// WHEN THE ROUND RESTARTS
//
public QS_OnRoundRefresh ( )
{
    static nPlayer = 0;

    for ( nPlayer = 1; nPlayer <= g_nMaxPlayers; nPlayer ++ )
    {
        //
        // CLEARS DATA
        //
        g_pnKills               [ nPlayer ]     =       0;
        g_pnKillsThisRound      [ nPlayer ]     =       0;

        QS_ClearString          ( g_pszRevengeStamp     [ nPlayer ] );

        g_pnRevengeStamp        [ nPlayer ]     =       0;
    }

    return  PLUGIN_CONTINUE;
}

//
// WHEN THE ROUND STARTS
//
public QS_OnRoundBegin ( )
{
    static nPlayer = 0;

    //
    // RESETS FIRST BLOOD
    //
    if ( g_bFBlood )
    {
        g_nFBlood = 0;
    }

    //
    // RESETS THE LAST MAN STANDING
    //
    if ( g_bTLMStanding )
    {
        g_bTLMStandingDone_TE   =   false;
        g_bTLMStandingDone_CT   =   false;
    }

    //
    // PREPARES ROUND START EVENT
    //
    if ( g_bRStart )
    {
        if ( g_bRStartMsg )
        {
            QS_UpdateHudMsgColor ( );

            set_hudmessage  ( g_nRed, g_nGreen, g_nBlue, QS_HUD_MSG_X_POS, QS_ROUND_Y_POS, _, _, QS_HUD_MSG_HOLD_TIME );
            QS_ShowHudMsg   ( QS_EVERYONE, g_pnHudMsgObj [ QS_HUD_ROUND ], g_szRStartMsg );
        }

        QS_ClientCmd        ( QS_EVERYONE, "SPK \"%a\"", ArrayGetStringHandle ( g_pRStart, random_num ( 0, g_nRStartSize - 1 ) ) );
    }

    //
    // RESETS HATTRICK DATA
    //
    if ( g_bHattrick )
    {
        for ( nPlayer = 1; nPlayer <= g_nMaxPlayers; nPlayer ++ )
        {
            g_pnKillsThisRound  [ nPlayer ]     =   0;
        }
    }

    return  PLUGIN_CONTINUE;
}

//
// WHEN ROUND ENDS
//
public QS_OnRoundEnd ( )
{
    // GETS HATTRICK READY
    //
    if ( g_bHattrick )
    {
        set_task ( QS_HATTRICK_ROUND_END_DELAY, "QS_Hattrick" );
    }

    // GETS FLAWLESS READY
    //
    if ( g_bFlawless )
    {
        set_task ( QS_FLAWLESS_ROUND_END_DELAY, "QS_Flawless" );
    }

    return  PLUGIN_CONTINUE;
}

//
// PREPARES HATTRICK
//
public QS_Hattrick ( )
{
    //
    // RETRIEVES THE LEADER'S ID
    //
    static nLeader =    0;

    nLeader =   QS_Leader   ( );

    //
    // IF ANY
    //
    if ( nLeader != QS_INVALID_PLAYER )
    {
        if ( g_pnKillsThisRound [ nLeader ]     >=      g_nMinKillsForHattrick )
        {
            if ( g_bHattrickMsg )
            {
                QS_UpdateHudMsgColor ( );

                set_hudmessage  ( g_nRed, g_nGreen, g_nBlue, QS_HUD_MSG_X_POS, QS_HATTRICK_Y_POS, _, _, QS_HUD_MSG_HOLD_TIME );
                QS_ShowHudMsg   ( QS_EVERYONE, g_pnHudMsgObj [ QS_HUD_HATTRICK ], g_szHattrickMsg, g_pszName [ nLeader ] );
            }

            QS_ClientCmd        ( QS_EVERYONE, "SPK \"%a\"", ArrayGetStringHandle ( g_pHattrick, random_num ( 0, g_nHattrickSize - 1 ) ) );
        }
    }
}

//
// PREPARES FLAWLESS
//
public QS_Flawless ( )
{
    static  nAliveTeam_1 = 0,   nAliveTeam_2 = 0,   nAllTeam_1 = 0,     nAllTeam_2 = 0;

    nAliveTeam_1    =   QS_ActivePlayersNum         ( true, 1 );
    nAliveTeam_2    =   QS_ActivePlayersNum         ( true, 2 );

    nAllTeam_1      =   nAliveTeam_1            +   QS_ActivePlayersNum ( false, 1 );
    nAllTeam_2      =   nAliveTeam_2            +   QS_ActivePlayersNum ( false, 2 );

    QS_UpdateHudMsgColor ( );

    set_hudmessage  ( g_nRed, g_nGreen, g_nBlue, QS_HUD_MSG_X_POS, QS_FLAWLESS_Y_POS, _, _, QS_HUD_MSG_HOLD_TIME );

    if      ( nAllTeam_1 == nAliveTeam_1 )
    {
        if ( g_bFlawlessMsg )
        {
            QS_ShowHudMsg   ( QS_EVERYONE, g_pnHudMsgObj [ QS_HUD_FLAWLESS ], g_szFlawlessMsg, g_szFlawlessTeamName_1 );
        }

        QS_ClientCmd        ( QS_EVERYONE, "SPK \"%a\"", ArrayGetStringHandle ( g_pFlawless, random_num ( 0, g_nFlawlessSize - 1 ) ) );
    }

    else if ( nAllTeam_2 == nAliveTeam_2 )
    {
        if ( g_bFlawlessMsg )
        {
            QS_ShowHudMsg   ( QS_EVERYONE, g_pnHudMsgObj [ QS_HUD_FLAWLESS ], g_szFlawlessMsg, g_szFlawlessTeamName_2 );
        }

        QS_ClientCmd        ( QS_EVERYONE, "SPK \"%a\"", ArrayGetStringHandle ( g_pFlawless, random_num ( 0, g_nFlawlessSize - 1 ) ) );
    }
}

//
// pfnMessageBegin ( )
//
// FIRED WHEN A MESSAGE BEGINS
//
public QS_FM_OnMsgBegin (   nDestination,   nType   )
{
    static nDeathMsg    =   QS_INVALID_MSG;
    static nVar         =   1;

    //
    // GETS THE DEATHMSG ID
    //
    if ( nDeathMsg      <   1   &&  nVar    !=  1024 )
    {
        nDeathMsg       =   get_user_msgid  ( "DeathMsg" );     /** DON'T CALL 'get_user_msgid ( )' FOREVER */

        nVar            ++;
    }

    //
    // IF GLOBALLY SENT
    //
    if ( nDeathMsg > 0 && \
            nType == nDeathMsg && \
                ( nDestination == MSG_ALL   ||  nDestination == MSG_BROADCAST ) )
    {
        g_bOnDeathMsg =             true;

        g_nDeathMsgByteStatus =     0;
    }

    return  PLUGIN_CONTINUE;
}

//
// pfnWriteByte ( )
//
// FIRED WHEN A BYTE IS BEING WRITTEN
//
public QS_FM_OnWriteByte    ( nByte )
{
    //
    // OUR DEATHMSG
    //
    if ( g_bOnDeathMsg )
    {
        //
        // GETS DATA
        //
        switch ( ++ g_nDeathMsgByteStatus )
        {
            case 1: /// KILLER ID
            {
                g_nKiller   =   nByte;
            }

            case 2: /// VICTIM ID
            {
                g_nVictim   =   nByte;
            }
        }
    }

    return  PLUGIN_CONTINUE;
}

//
// pfnMessageEnd ( )
//
// FIRED WHEN A MESSAGE ENDS
//
public QS_FM_OnMsgEnd   ( )
{
    //
    // OUR DEATHMSG
    //
    if ( g_bOnDeathMsg )
    {
        g_bOnDeathMsg =                             false;

        g_nDeathMsgByteStatus =                     0;

        if ( g_bDeathMsgOnly )
        {
            g_nWeapon = g_nPlace = g_nTeamKill =    0;
        }

        //
        // FIRES
        //
        set_task ( 0.0, "QS_ProcessDeathMsg" );
    }

    return  PLUGIN_CONTINUE;
}

//
// WHEN A PLAYER DIES
//
// THIS IS EXECUTED AFTER THE XSTATS MODULE'S "client_death" FORWARD
//
public QS_ProcessDeathMsg ( )
{
    //
    // DECLARES THE HIT PLACE AND THE WEAPON ID
    //
    static nPlace = 0, nWeapon = 0;

    //
    // SETS THE DECLARED VARIABLES TO ZERO
    //
    nPlace = nWeapon = 0;

    //
    // SANITY CHECK
    //
    if ( !QS_IsPlayer ( g_nVictim ) || !g_pbConnected [ g_nVictim ] || !QS_IsPlayerOrWorld ( g_nKiller ) )
    {
        return  PLUGIN_CONTINUE;
    }

    //
    // PREPARES THE WEAPON ID AND THE HIT PLACE
    //
    get_user_attacker   ( g_nVictim, nWeapon, nPlace );

    //
    // POSSIBLE WEAPON ID FIX
    //
    if ( g_nWeapon < 1 )
    {
        if ( nWeapon < 1 )
        {
            if ( g_pbConnected  [ g_nKiller ] )
            {
                g_nWeapon   =   get_user_weapon ( g_nKiller );
            }
        }

        else
        {
            g_nWeapon       =   nWeapon;
        }
    }

    //
    // POSSIBLE HIT PLACE FIX
    //
    if ( g_nPlace < 1   &&  nPlace > 0 )
    {
        g_nPlace    =   nPlace;
    }

    //
    // PREPARES THE TEAM KILL BOOLEAN IF NEEDED
    //
    if ( g_bDeathMsgOnly )
    {
        if ( g_pbConnected [ g_nKiller ] )
        {
            g_nTeamKill =   ( get_user_team ( g_nKiller )   ==  get_user_team ( g_nVictim ) )   ?   1   :   0;
        }

        else
        {
            g_nTeamKill =   0;
        }
    }

    //
    // PROCESSES DEATH
    //
    QS_ProcessPlayerDeath   ( g_nKiller, g_nVictim, g_nWeapon, g_nPlace, g_nTeamKill );

    return  PLUGIN_CONTINUE;
}


/*************************************************************************************
******* FUNCTIONS ********************************************************************
*************************************************************************************/

//
// PROCESSES THE CLIENT DEATH STUFF FOR ALL MODS
//
static QS_ProcessPlayerDeath ( nKiller, const &nVictim, const &nWeapon, const &nPlace, const &nTeamKill )
{
    //
    // VARIABLES
    //
    static  nIter = 0, Float: fGameTime = 0.0, szWeapon [ 64 ], szSnd [ 256 ], szMsg [ QS_HUD_MSG_MAX_LEN ], \
            bool: bKilledByWorldDamage = false /** OR BY THE 'KILL' COMMAND */;

    //
    // RESET THE SUICIDE TYPE [ WORLD DAMAGE / 'KILL' COMMAND ]
    //
    bKilledByWorldDamage = false;

    //
    // RESETS KILLS FOR VICTIM
    //
    if ( g_bKStreak )
    {
        g_pnKills [ nVictim ] = 0;
    }

    //
    // INVALID KILLER ( WORLD, ... )
    //
    if ( !g_pbConnected [ nKiller ] )
    {
        if ( nKiller <  1 )
        {
            nKiller =                   nVictim;

            bKilledByWorldDamage =      true;
        }

        else
        {
            return  PLUGIN_CONTINUE;
        }
    }

    //
    // PREPARES HUD MESSAGE COLOR
    //
    QS_UpdateHudMsgColor ( );

    //
    // PREPARES MINOR EVENTS HUD MESSAGE
    //
    set_hudmessage ( g_nRed, g_nGreen, g_nBlue, QS_HUD_MSG_X_POS, QS_EVENT_Y_POS, _, _, QS_HUD_MSG_HOLD_TIME );

    //
    // REVENGE KILLER STAMP
    //
    if ( g_bRevenge )
    {
        g_pszRevengeStamp       [ nVictim ]     =       g_pszName           [ nKiller ];

        g_pnRevengeStamp        [ nVictim ]     =       g_pnUserId          [ nKiller ];
    }

    //
    // SUICIDE
    //
    if ( nVictim == nKiller )
    {
        if ( g_bSuicide )
        {
            if ( g_bSuicideMsg )
            {
                QS_ShowHudMsg   ( QS_EVERYONE, g_pnHudMsgObj [ QS_HUD_EVENT ], g_szSuicideMsg, g_pszName [ nVictim ] );
            }

            QS_ClientCmd        ( QS_EVERYONE, "SPK \"%a\"", ArrayGetStringHandle ( g_pSuicide, random_num ( 0, g_nSuicideSize - 1 ) ) );
        }

        if ( g_bHattrick )
        {
            if ( !bKilledByWorldDamage )
            {
                if ( g_bHattrickDecrease )
                {
                    g_pnKillsThisRound  [ nVictim ] --;
                }
            }
        }
    }

    //
    // NORMAL DEATH
    //
    else
    {
        if ( g_bKStreak )
        {
            g_pnKills               [ nKiller ] ++;
        }

        if ( g_bHattrick )
        {
            g_pnKillsThisRound      [ nKiller ] ++;
        }

        //
        // WEAPON NAME
        //
        if ( nWeapon > 0 )
        {
            get_weaponname  ( nWeapon, szWeapon, charsmax ( szWeapon ) );
        }

        //
        // NO WEAPON
        //
        else
        {
            QS_ClearString  ( szWeapon );
        }

        if ( g_bRevenge && \
                equali ( g_pszName [ nVictim ], g_pszRevengeStamp [ nKiller ] ) && \
                    g_pnUserId [ nVictim ] == g_pnRevengeStamp [ nKiller ] )
        {
            g_pnRevengeStamp    [ nKiller ] =   0;

            QS_ClearString      ( g_pszRevengeStamp [ nKiller ] );

            //
            // PREPARES HUD MESSAGE COLOR
            //
            QS_UpdateHudMsgColor ( );

            //
            // PREPARES REVENGE HUD MESSAGE
            //
            set_hudmessage ( g_nRed, g_nGreen, g_nBlue, QS_HUD_MSG_X_POS, QS_REVENGE_Y_POS, _, _, QS_HUD_MSG_HOLD_TIME );

            if ( g_bRevengeMsgKiller )
            {
                QS_ShowHudMsg   ( nKiller, g_pnHudMsgObj [ QS_HUD_REVENGE ], g_szRevengeMsgKiller, g_pszName [ nVictim ] );
            }

            if ( g_bRevengeMsgVictim    &&  !g_bRevengeOnlyKiller )
            {
                QS_ShowHudMsg   ( nVictim, g_pnHudMsgObj [ QS_HUD_REVENGE ], g_szRevengeMsgVictim, g_pszName [ nKiller ] );
            }

            QS_ClientCmd        ( nKiller, "SPK \"%a\"", ArrayGetStringHandle ( g_pRevenge, random_num ( 0, g_nRevengeSize - 1 ) ) );

            if ( !g_bRevengeOnlyKiller )
            {
                QS_ClientCmd    ( nVictim, "SPK \"%a\"", ArrayGetStringHandle ( g_pRevenge, random_num ( 0, g_nRevengeSize - 1 ) ) );
            }

            //
            // PREPARES HUD MESSAGE COLOR
            //
            QS_UpdateHudMsgColor ( );

            //
            // PREPARES MINOR EVENTS HUD MESSAGE
            //
            set_hudmessage ( g_nRed, g_nGreen, g_nBlue, QS_HUD_MSG_X_POS, QS_EVENT_Y_POS, _, _, QS_HUD_MSG_HOLD_TIME );
        }

        if ( g_bHShot   &&  nPlace  ==  HIT_HEAD )
        {
            if ( g_bHShotMsg )
            {
                QS_ShowHudMsg   ( QS_EVERYONE, g_pnHudMsgObj [ QS_HUD_EVENT ], g_szHShotMsg, g_pszName [ nKiller ], g_pszName [ nVictim ] );
            }

            QS_ClientCmd        ( g_bHShotOnlyKiller ? nKiller : QS_EVERYONE, "SPK \"%a\"", ArrayGetStringHandle ( g_pHShot, random_num ( 0, g_nHShotSize - 1 ) ) );
        }

        if ( g_bFBlood  &&  ++ g_nFBlood == 1 )
        {
            if ( g_bFBloodMsg )
            {
                QS_ShowHudMsg   ( QS_EVERYONE, g_pnHudMsgObj [ QS_HUD_EVENT ], g_szFBloodMsg, g_pszName [ nKiller ] );
            }

            QS_ClientCmd        ( QS_EVERYONE, "SPK \"%a\"", ArrayGetStringHandle ( g_pFBlood, random_num ( 0, g_nFBloodSize - 1 ) ) );
        }

        if ( g_bTKill   &&  nTeamKill > 0 )
        {
            if ( g_bTKillMsg )
            {
                QS_ShowHudMsg   ( QS_EVERYONE, g_pnHudMsgObj [ QS_HUD_EVENT ], g_szTKillMsg, g_pszName [ nKiller ] );
            }

            QS_ClientCmd        ( QS_EVERYONE, "SPK \"%a\"", ArrayGetStringHandle ( g_pTKill, random_num ( 0, g_nTKillSize - 1 ) ) );
        }

        if ( g_bGrenade && ( containi ( szWeapon, "RECK" ) != -1 || \
                                containi ( szWeapon, "ROCK" ) != -1 || \
                                    containi ( szWeapon, "MK" ) != -1 || \
                                        containi ( szWeapon, "GRANATE" ) != -1 || \
                                            containi ( szWeapon, "BOMB" ) != -1 || \
                                                containi ( szWeapon, "GREN" ) != -1 || \
                                                    containi ( szWeapon, "PIAT" ) != -1 || \
                                                        containi ( szWeapon, "BAZOOKA" ) != -1 || \
                                                            containi ( szWeapon, "PANZER" ) != -1 ) )
        {
            if ( g_bGrenadeMsg )
            {
                QS_ShowHudMsg   ( QS_EVERYONE, g_pnHudMsgObj [ QS_HUD_EVENT ], g_szGrenadeMsg, g_pszName [ nKiller ], g_pszName [ nVictim ] );
            }

            QS_ClientCmd        ( QS_EVERYONE, "SPK \"%a\"", ArrayGetStringHandle ( g_pGrenade, random_num ( 0, g_nGrenadeSize - 1 ) ) );
        }

        if ( g_bKnife && ( containi ( szWeapon, "KNIFE" ) != -1 || \
                                containi ( szWeapon, "SPADE" ) != -1 || \
                                    containi ( szWeapon, "SATCHEL" ) != -1 ) )
        {
            if ( g_bKnifeMsg )
            {
                QS_ShowHudMsg   ( QS_EVERYONE, g_pnHudMsgObj [ QS_HUD_EVENT ], g_szKnifeMsg, g_pszName [ nKiller ], g_pszName [ nVictim ] );
            }

            QS_ClientCmd        ( QS_EVERYONE, "SPK \"%a\"", ArrayGetStringHandle ( g_pKnife, random_num ( 0, g_nKnifeSize - 1 ) ) );
        }

        if ( g_bDKill )
        {
            //
            // GAME TIME
            //
            fGameTime = get_gametime ( );

            if ( g_pfLastKillTimeStamp [ nKiller ]  >   fGameTime )
            {
                if ( g_bDKillMsg )
                {
                    QS_ShowHudMsg   ( QS_EVERYONE, g_pnHudMsgObj [ QS_HUD_EVENT ], g_szDKillMsg, g_pszName [ nKiller ], g_pszName [ nVictim ] );
                }

                QS_ClientCmd        ( QS_EVERYONE, "SPK \"%a\"", ArrayGetStringHandle ( g_pDKill, random_num ( 0, g_nDKillSize - 1 ) ) );
            }

            g_pfLastKillTimeStamp   [ nKiller ]     =   fGameTime   +   0.1;
        }

        if ( g_bKStreak )
        {
            for ( nIter = 0; nIter < g_nKStreakSize; nIter ++ )
            {
                if ( g_pnKills  [ nKiller ]     ==      ArrayGetCell    ( g_pKStreakReqKills,   nIter ) )
                {
                    ArrayGetString      (   g_pKStreakMsgs, nIter,      szMsg,  charsmax ( szMsg ) );
                    ArrayGetString      (   g_pKStreakSnds, nIter,      szSnd,  charsmax ( szSnd ) );

                    QS_DisplayKStreak   (   nKiller,        szMsg,      szSnd );

                    break;
                }
            }
        }
    }

    return  PLUGIN_CONTINUE;
}

//
// LOADS THE CONFIGURATION FILE
//
static QS_LoadSettings ( )
{
    //
    // PREPARES THE CONFIGURATION FILES DIRECTORY
    //
    new szFile [ 256 ];

    get_configsdir ( szFile,    charsmax ( szFile ) );

    //
    // APPENDS THE CONFIGURATION FILE'S NAME
    //
    add ( szFile,   charsmax ( szFile ),    QS_CFG_FILE_NAME );

    //
    // OPENS THE FILE
    //
    new nFile =     fopen ( szFile,         "r" );

    //
    // NO FILE
    //
    if ( !nFile )
    {
        return  PLUGIN_CONTINUE;
    }

    //
    // PREPARES THE FILE LINES
    //
    new szLine [ 2048 ], szKey [ 2048 ], szVal [ 2048 ], szType [ 256 ], szSnd [ 512 ], \
        szReqKills [ 128 ], szDummy [ 64 ], szMsg [ QS_HUD_MSG_MAX_LEN ], nVal = 0;

    //
    // READS THE FILE
    //
    while ( !feof ( nFile ) )
    {
        //
        // GETS LINE
        //
        fgets ( nFile,  szLine, charsmax ( szLine ) );

        //
        // TRIMS LINE OFF
        //
        trim ( szLine );

        //
        // CHECKS FOR VALIDITY
        //
        if ( QS_EmptyString ( szLine ) || \
                szLine [ 0 ] == ';' || \
                    szLine [ 0 ] == '#' || \
                        ( szLine [ 0 ] == '/' && szLine [ 1 ] == '/' ) )
        {
            continue;
        }

        //
        // PREPARE
        //
        QS_ClearString ( szKey );
        QS_ClearString ( szVal );

        //
        // SPLITS STRING IN TOKENS
        //
        strtok ( szLine, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), '=' );

        //
        // TRIMS KEY
        //
        trim ( szKey );

        //
        // TRIMS VALUE
        //
        trim ( szVal );

        //
        // SETTINGS
        //

        if      ( equali ( szKey, "ENABLE/DISABLE PLUGIN" ) || equali ( szKey, "ENABLE/ DISABLE PLUGIN" ) ) /** COMPATIBILITY */
        {
            g_bEnabled =                bool:       str_to_num ( szVal );
        }

        else if ( equali ( szKey, "HEADSHOT ONLY KILLER" ) )
        {
            g_bHShotOnlyKiller =        bool:       str_to_num ( szVal );
        }

        else if ( equali ( szKey, "MIN FRAGS FOR HATTRICK" ) )
        {
            g_nMinKillsForHattrick =                str_to_num ( szVal );
        }

        else if ( equali ( szKey, "DECREASE FRAG IN CASE OF 'KILL' COMMAND SUICIDE" ) )
        {
            g_bHattrickDecrease =       bool:       str_to_num ( szVal );
        }

        else if ( equali ( szKey, "REVENGE ONLY FOR KILLER" ) )
        {
            g_bRevengeOnlyKiller =      bool:       str_to_num ( szVal );
        }

        //
        // HUD MESSAGES
        //

        else if     ( equali ( szKey,   "HUDMSG RED" ) )
        {
            if      ( equal ( szVal,    "_" ) )
            {
                g_bRandomRed =          true;
            }

            else
            {
                g_nRed =                str_to_num ( szVal );
            }
        }

        else if     ( equali ( szKey,   "HUDMSG GREEN" ) )
        {
            if      ( equal ( szVal,    "_" ) )
            {
                g_bRandomGreen =        true;
            }

            else
            {
                g_nGreen =              str_to_num ( szVal );
            }
        }

        else if     ( equali ( szKey,   "HUDMSG BLUE" ) )
        {
            if      ( equal ( szVal,    "_" ) )
            {
                g_bRandomBlue =         true;
            }

            else
            {
                g_nBlue =               str_to_num ( szVal );
            }
        }

        //
        // KILLS STREAK SOUNDS
        //
        else if ( equali ( szKey, "SOUND" ) )
        {
            //
            // PREPARE
            //
            QS_ClearString ( szType );

            parse ( szVal, szDummy, charsmax ( szDummy ), szType, charsmax ( szType ) );

            trim ( szType );

            if ( equali ( szType, "REQUIREDKILLS" ) )
            {
                //
                // PREPARE
                //
                QS_ClearString ( szReqKills );
                QS_ClearString ( szSnd );

                parse ( szVal, szDummy, charsmax ( szDummy ), szDummy, charsmax ( szDummy ), szReqKills, charsmax ( szReqKills ), \
                    szDummy, charsmax ( szDummy ), szSnd, charsmax ( szSnd ) );

                trim ( szReqKills );
                trim ( szSnd );

                if ( !QS_EmptyString ( szReqKills ) &&      ( nVal = abs ( str_to_num ( szReqKills ) ) )    >   0 )
                {
                    ArrayPushCell   ( g_pKStreakReqKills,   nVal );
                }

                else
                {
                    ArrayPushCell   ( g_pKStreakReqKills,   QS_INVALID_REQUIRED_KILLS );

                    log_to_file     ( QS_LOG_FILE_NAME,     "****************************************************************************************************************" );
                    log_to_file     ( QS_LOG_FILE_NAME,     "Bad Required Kills ('REQUIREDKILLS') [ %s ] Inside Line [ %s ].", szReqKills, szLine );
                    log_to_file     ( QS_LOG_FILE_NAME,     "This Sound Will Be Ignored. It Will Be Precached, If Set, So The Players Will Download It." );
                    log_to_file     ( QS_LOG_FILE_NAME,     "It Will Never Play." );
                }

                ArrayPushString     ( g_pKStreakSnds,       szSnd );
            }

            else if ( equali ( szType, "MESSAGE" ) )
            {
                //
                // PREPARE
                //
                QS_ClearString ( szMsg );

                strtok ( szVal, szDummy, charsmax ( szDummy ), szMsg, charsmax  ( szMsg ), '@' );

                trim ( szMsg );

                ArrayPushString ( g_pKStreakMsgs, szMsg );
            }
        }

        //
        // EVENTS ON/ OFF
        //

        else if ( equali ( szKey, "KILLSTREAK EVENT" ) || equali ( szKey, "KILLSSTREAK EVENT" ) ) /** COMPATIBILITY */
        {
            g_bKStreak =            bool: str_to_num ( szVal );
        }

        else if ( equali ( szKey, "REVENGE EVENT" ) )
        {
            g_bRevenge =            bool: str_to_num ( szVal );
        }

        else if ( equali ( szKey, "HEADSHOT EVENT" ) )
        {
            g_bHShot =              bool: str_to_num ( szVal );
        }

        else if ( equali ( szKey, "SUICIDE EVENT" ) )
        {
            g_bSuicide =            bool: str_to_num ( szVal );
        }

        else if ( equali ( szKey, "NADE EVENT" ) )
        {
            g_bGrenade =            bool: str_to_num ( szVal );
        }

        else if ( equali ( szKey, "TEAMKILL EVENT" ) )
        {
            g_bTKill =              bool: str_to_num ( szVal );
        }

        else if ( equali ( szKey, "KNIFE EVENT" ) )
        {
            g_bKnife =              bool: str_to_num ( szVal );
        }

        else if ( equali ( szKey, "FIRSTBLOOD EVENT" ) )
        {
            g_bFBlood =             bool: str_to_num ( szVal );
        }

        else if ( equali ( szKey, "ROUNDSTART EVENT" ) )
        {
            g_bRStart =             bool: str_to_num ( szVal );
        }

        else if ( equali ( szKey, "DOUBLEKILL EVENT" ) )
        {
            g_bDKill =              bool: str_to_num ( szVal );
        }

        else if ( equali ( szKey, "HATTRICK EVENT" ) )
        {
            g_bHattrick =           bool: str_to_num ( szVal );
        }

        else if ( equali ( szKey, "TLMSTANDING EVENT" ) )
        {
            g_bTLMStanding =        bool: str_to_num ( szVal );
        }

        else if ( equali ( szKey, "FLAWLESS VICTORY" ) )
        {
            g_bFlawless =           bool: str_to_num ( szVal );
        }

        //
        // EVENT SOUNDS
        //

        else if ( equali ( szKey, "HEADSHOT SOUNDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pHShot, szKey );
            }
        }

        else if ( equali ( szKey, "REVENGE SOUNDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pRevenge, szKey );
            }
        }

        else if ( equali ( szKey, "SUICIDE SOUNDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pSuicide, szKey );
            }
        }

        else if ( equali ( szKey, "NADE SOUNDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pGrenade, szKey );
            }
        }

        else if ( equali ( szKey, "TEAMKILL SOUNDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pTKill, szKey );
            }
        }

        else if ( equali ( szKey, "KNIFE SOUNDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pKnife, szKey );
            }
        }

        else if ( equali ( szKey, "FIRSTBLOOD SOUNDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pFBlood, szKey );
            }
        }

        else if ( equali ( szKey, "ROUNDSTART SOUNDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pRStart, szKey );
            }
        }

        else if ( equali ( szKey, "DOUBLEKILL SOUNDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pDKill, szKey );
            }
        }

        else if ( equali ( szKey, "HATTRICK SOUNDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pHattrick, szKey );
            }
        }

        else if ( equali ( szKey, "TLMSTANDING SOUNDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pTLMStanding, szKey );
            }
        }

        else if ( equali ( szKey, "TLMSTANDING WORDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pTLMStandingWords, szKey );
            }
        }

        else if ( equali ( szKey, "FLAWLESS SOUNDS" ) )
        {
            while ( !QS_EmptyString ( szVal ) && strtok ( szVal, szKey, charsmax ( szKey ), szVal, charsmax ( szVal ), ',' ) )
            {
                trim ( szKey );
                trim ( szVal );

                ArrayPushString ( g_pFlawless, szKey );
            }
        }

        //
        // MESSAGE STRINGS
        //

        else if ( equali ( szKey, "HEADSHOT HUDMSG" ) )
        {
            copy ( g_szHShotMsg, charsmax ( g_szHShotMsg ), szVal );
        }

        else if ( equali ( szKey, "SUICIDE HUDMSG" ) )
        {
            copy ( g_szSuicideMsg, charsmax ( g_szSuicideMsg ), szVal );
        }

        else if ( equali ( szKey, "NADE HUDMSG" ) )
        {
            copy ( g_szGrenadeMsg, charsmax ( g_szGrenadeMsg ), szVal );
        }

        else if ( equali ( szKey, "TEAMKILL HUDMSG" ) )
        {
            copy ( g_szTKillMsg, charsmax ( g_szTKillMsg ), szVal );
        }

        else if ( equali ( szKey, "KNIFE HUDMSG" ) )
        {
            copy ( g_szKnifeMsg, charsmax ( g_szKnifeMsg ), szVal );
        }

        else if ( equali ( szKey, "FIRSTBLOOD HUDMSG" ) )
        {
            copy ( g_szFBloodMsg, charsmax ( g_szFBloodMsg ), szVal );
        }

        else if ( equali ( szKey, "ROUNDSTART HUDMSG" ) )
        {
            copy ( g_szRStartMsg, charsmax ( g_szRStartMsg ), szVal );
        }

        else if ( equali ( szKey, "DOUBLEKILL HUDMSG" ) )
        {
            copy ( g_szDKillMsg, charsmax ( g_szDKillMsg ), szVal );
        }

        else if ( equali ( szKey, "HATTRICK HUDMSG" ) )
        {
            copy ( g_szHattrickMsg, charsmax ( g_szHattrickMsg ), szVal );
        }

        else if ( equali ( szKey, "TLMSTANDING TEAM HUDMSG" ) )
        {
            copy ( g_szTLMStandingTeamMsg, charsmax ( g_szTLMStandingTeamMsg ), szVal );
        }

        else if ( equali ( szKey, "TLMSTANDING SELF HUDMSG" ) )
        {
            copy ( g_szTLMStandingSelfMsg, charsmax ( g_szTLMStandingSelfMsg ), szVal );
        }

        else if ( equali ( szKey, "FLAWLESS VICTORY HUDMSG" ) )
        {
            copy ( g_szFlawlessMsg, charsmax ( g_szFlawlessMsg ), szVal );
        }

        else if ( equali ( szKey, "REVENGE KILLER MESSAGE" ) )
        {
            copy ( g_szRevengeMsgKiller, charsmax ( g_szRevengeMsgKiller ), szVal );
        }

        else if ( equali ( szKey, "REVENGE VICTIM MESSAGE" ) )
        {
            copy ( g_szRevengeMsgVictim, charsmax ( g_szRevengeMsgVictim ), szVal );
        }

        else if ( equali ( szKey, "TERRO TEAM NAME" ) || equali ( szKey, "TE TEAM NAME" ) ) /** COMPATIBILITY */
        {
            copy ( g_szFlawlessTeamName_1, charsmax ( g_szFlawlessTeamName_1 ), szVal );
        }

        else if ( equali ( szKey, "CT TEAM NAME" ) )
        {
            copy ( g_szFlawlessTeamName_2, charsmax ( g_szFlawlessTeamName_2 ), szVal );
        }
    }

    //
    // CLOSES
    //
    fclose ( nFile );

    return  PLUGIN_CONTINUE;
}

//
// DISPLAYS K. STREAK GLOBALLY
//
static QS_DisplayKStreak ( const &nKiller, const szMsg [ ], const szSnd [ ] )
{
    QS_UpdateHudMsgColor ( );

    set_hudmessage  ( g_nRed, g_nGreen, g_nBlue, QS_HUD_MSG_X_POS, QS_STREAK_Y_POS, _, _, QS_HUD_MSG_HOLD_TIME );
    QS_ShowHudMsg   ( QS_EVERYONE, g_pnHudMsgObj [ QS_HUD_STREAK ], szMsg, g_pszName [ nKiller ] );

    QS_ClientCmd    ( QS_EVERYONE, "SPK \"%s\"", szSnd );

    return  PLUGIN_CONTINUE;
}

//
// RETRIEVES ACTIVE PLAYERS COUNT
//
// bAlive   [ TRUE/ FALSE ]
// nTeam    [ QS_INVALID_TEAM/ 1/ 2/ 3 ]
//
static QS_ActivePlayersNum ( bool: bAlive, nTeam = QS_INVALID_TEAM )
{
    //
    // PLAYERS COUNT
    //
    static nTotal = 0, nPlayer = 0;

    //
    // ITERATES BETWEEN PLAYERS
    //
    for ( nTotal = 0, nPlayer = 1; nPlayer <= g_nMaxPlayers; nPlayer ++ )
    {
        //
        // CONNECTED, NOT HLTV, IN SPECIFIED TEAM AND ALIVE/ DEAD
        //
        if ( ( g_pbConnected [ nPlayer ] ) && ( !( g_pbHLTV [ nPlayer ] ) ) && \
            ( ( nTeam == QS_INVALID_TEAM ) || ( get_user_team ( nPlayer ) == nTeam ) ) && \
                ( bAlive == bool: is_user_alive ( nPlayer ) ) )
        {
            //
            // TOTAL = TOTAL + 1
            //
            nTotal ++;
        }
    }

    //
    // GETS THE TOTAL
    //
    return nTotal;
}

//
// RETRIEVES THE LEADER OF THIS ROUND
// RETURNS "QS_INVALID_PLAYER" IF THERE IS NO LEADER
//
static QS_Leader ( )
{
    //
    // DECLARES VARIABLES
    //
    static nLeader = 0, nKills = 0, nPlayer = 0;

    //
    // ITERATES BETWEEN CLIENTS
    //
    for ( nPlayer = 1, nLeader = QS_INVALID_PLAYER, nKills = 0; nPlayer <= g_nMaxPlayers; nPlayer ++ )
    {
        //
        // CONNECTED AND NOT HLTV
        //
        if ( g_pbConnected [ nPlayer ]  &&  !g_pbHLTV [ nPlayer ] )
        {
            //
            // HAS MANY KILLS THAN THE ONE PREVIOUSLY CHECKED
            //
            if ( g_pnKillsThisRound [ nPlayer ] >   nKills )
            {
                //
                // THIS IS THE NEW LEADER
                //
                nKills      =       g_pnKillsThisRound [ nPlayer ];

                nLeader     =       nPlayer;
            }
        }
    }

    //
    // GETS THE LEADER ID
    //
    return nLeader;
}

//
// PROCESSES HUD MESSAGE
//
static QS_ShowHudMsg ( nTo, const &nObj, const szRules [ ], any: ... )
{
    //
    // ARGUMENT FORMAT
    //
    static szBuffer [ QS_HUD_MSG_MAX_LEN ], nPlayer = 0;

    //
    // SANITY CHECK
    //
    if ( QS_EmptyString ( szRules ) )
    {
        return  PLUGIN_CONTINUE;
    }

    vformat ( szBuffer, charsmax ( szBuffer ), szRules, 4 );

    //
    // SANITY CHECK
    //
    if ( QS_EmptyString ( szBuffer ) )
    {
        return  PLUGIN_CONTINUE;
    }

    //
    // SPECIFIED CLIENT
    //
    if ( nTo > 0 && g_pbConnected [ nTo ] && !g_pbBOT [ nTo ] && !g_pbHLTV [ nTo ] && !g_pbDisabled [ nTo ] )
    {
        ShowSyncHudMsg ( nTo, nObj, szBuffer );
    }

    //
    // NO TARGET
    //
    else if ( nTo < 1 )
    {
        for ( nPlayer = 1; nPlayer <= g_nMaxPlayers; nPlayer ++ )
        {
            if ( g_pbConnected [ nPlayer ] && !g_pbBOT [ nPlayer ] && !g_pbHLTV [ nPlayer ] && !g_pbDisabled [ nPlayer ] )
            {
                ShowSyncHudMsg ( nPlayer, nObj, szBuffer );
            }
        }
    }

    return  PLUGIN_CONTINUE;
}

//
// PROCESSES CLIENT COMMAND
//
static QS_ClientCmd ( nTo, const szRules [ ], any: ... )
{
    //
    // ARGUMENT FORMAT
    //
    static szBuffer [ 256 ], nPlayer = 0;

    //
    // SANITY CHECK
    //
    if ( QS_EmptyString ( szRules ) )
    {
        return  PLUGIN_CONTINUE;
    }

    vformat ( szBuffer, charsmax ( szBuffer ), szRules, 3 );

    //
    // SANITY CHECK
    //
    if ( QS_EmptyString ( szBuffer ) || equali ( szBuffer, "SPK \"\"" ) )
    {
        return  PLUGIN_CONTINUE;
    }

    //
    // SPECIFIED CLIENT
    //
    if ( nTo > 0 && g_pbConnected [ nTo ] && !g_pbBOT [ nTo ] && !g_pbHLTV [ nTo ] && !g_pbDisabled [ nTo ] )
    {
        client_cmd ( nTo, szBuffer );
    }

    //
    // NO TARGET
    //
    else if ( nTo < 1 )
    {
        for ( nPlayer = 1; nPlayer <= g_nMaxPlayers; nPlayer ++ )
        {
            if ( g_pbConnected [ nPlayer ] && !g_pbBOT [ nPlayer ] && !g_pbHLTV [ nPlayer ] && !g_pbDisabled [ nPlayer ] )
            {
                client_cmd ( nPlayer, szBuffer );
            }
        }
    }

    return  PLUGIN_CONTINUE;
}

//
// CLEARS STRING
//
static QS_ClearString ( szString [ ] )
{
    szString [ 0 ] =    EOS;

    return  PLUGIN_CONTINUE;
}

//
// EMPTY STRING
//
static bool: QS_EmptyString ( const szString [ ] )
{
    return  szString [ 0 ]  ==  EOS;
}

//
// CHECKS THE MOD NAME
//
static QS_CheckMod ( )
{
    if ( QS_EmptyString ( g_szMod ) )
    {
        get_modname ( g_szMod,  charsmax ( g_szMod ) );
    }

    return  PLUGIN_CONTINUE;
}

//
// CSTRIKE OR CZERO RUNNING
//
static bool: QS_CSCZRunning ( )
{
    QS_CheckMod ( );

    return  equali ( g_szMod, "CS", 2 ) ||  equali ( g_szMod, "CZ", 2 );
}

//
// DAY OF DEFEAT RUNNING
//
static bool: QS_DODRunning ( )
{
    QS_CheckMod ( );

    return  bool: equali ( g_szMod, "DOD", 3 );
}

//
// XSTATS AVAILABLE
//
static bool: QS_XStatsAvail ( )
{
    static      bool: bChecked = false,     bool: bAvail = false;

    if ( !bChecked )
    {
        bChecked =      true;

        bAvail =        bool: module_exists ( "xstats" );
    }

    return  bAvail;
}

//
// TEAM TOTAL ALIVE AND IF ONLY ONE PLAYER IS ALIVE IN THAT TEAM, THEIR ID
//
static QS_GetTeamTotalAlive ( nTeam, &nPlayer = QS_INVALID_PLAYER )
{
    static pnPlayers [ 32 ], nTotal = 0;

    get_players ( pnPlayers, nTotal, "aeh", ( ( nTeam == QS_CSCZ_TEAM_TE ) ? "TERRORIST" : "CT" ) );

    if ( nTotal ==  1 )
    {
        nPlayer =   pnPlayers [ 0 ];
    }

    else
    {
        nPlayer =   QS_INVALID_PLAYER;
    }

    return  nTotal;
}

//
// UPDATES THE HUD MESSAGE'S COLOR
//
static QS_UpdateHudMsgColor ( )
{
    if ( g_bRandomRed )
    {
        g_nRed              =       random_num ( 0, QS_MAX_BYTE );
    }

    if ( g_bRandomGreen )
    {
        g_nGreen            =       random_num ( 0, QS_MAX_BYTE );
    }

    if ( g_bRandomBlue )
    {
        g_nBlue             =       random_num ( 0, QS_MAX_BYTE );
    }

    return  PLUGIN_CONTINUE;
}

static bool: QS_IsPlayer ( const &nId )
{
    return  ( nId < 1 || nId > g_nMaxPlayers ) ? false : true;
}

static bool: QS_IsPlayerOrWorld ( const &nId )
{
    return  ( nId < 0 || nId > g_nMaxPlayers ) ? false : true;
}
