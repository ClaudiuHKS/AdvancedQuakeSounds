# AQS

## Advanced Quake Sounds ##

Advanced Quake Sounds For AMX Mod X — **https://forums.alliedmods.net/**

**https://forums.alliedmods.net/showthread.php?t=152034**

## Installation ##

Upload **`AQS.ini`** to **`/addons/amxmodx/configs/`**

Upload **`AQS.amxx`** to **`/addons/amxmodx/plugins/`**

Upload **`AQS`** folder to **`/sound/`**

If **`CSTRIKE`** or **`CZERO`**, upload **`orpheu`** folder to **`/addons/amxmodx/configs/`**

If already running **`ReAPI`**, ignore **`Orpheu`** installation

Download [Orpheu](https://github.com/Arkshine/Orpheu/releases)

Type **`AQS.amxx`** in **`/addons/amxmodx/configs/plugins.ini`**

## Pictures ##

**`CS/ CZ`**

![CS/ CZ](https://hattrick.go.ro/aqs-cscz.png)

**`DOD`**

![DOD](https://hattrick.go.ro/aqs-dod.png)

## Windows CS/ CZ AMX Mod X Game Data `g_pGameRules` Signatures ( *OLD* & *NEW* ) ##

- `/addons/amxmodx/data/gamedata/common.games/globalvars.engine.txt` (ONLY if your game server HAS this file)

```C++
/**
 * Do not edit this file.  Any changes will be overwritten by the gamedata
 * updater or by upgrading your AMX Mod X install.
 *
 * To override data in this file, create a subdirectory named "custom" and
 * place your own gamedata file(s) inside of it.  Such files will be parsed
 * after AMXX's own.
 *
 * For more information, see http://wiki.alliedmods.net/Gamedata_Updating_(AMX_Mod_X)
 */

"Games"
{
    "#default"
    {
        "Offsets"
        {
            "svs"                   /// Used with   pfnGetCurrentPlayer     base address
            {
                "windows"           "8"
            }
        }

        "Addresses"
        {
            "realtime"
            {
                "windows"
                {
                    "signature"     "realtime"

                    "read"          "2"
                }
            }

            "sv"
            {
                "windows"
                {
                    "signature"     "sv"

                    "read"          "2"
                }
            }

            "g_pGameRules"
            {
                "signature"         "g_pGameRules"

                "windows"
                {
                    ///
                    /// "read"      "2"     /// [ HLDS 2020 ]   CS/ CZ
                    ///
                    "read"          "1"     /// [ HLDS 2023 ]   CS/ CZ
                    ///
                }

                "read"              "0"
            }
        }

        "Signatures"
        {
            "svs"                   /// server_static_t     svs
            {
                "library"           "engine"
                "linux"             "@svs"
                "mac"               "@svs"
            }

            "sv"                    /// server_t            sv
            {
                ///
                "library"           "engine"
                ///
                /// "windows"       "\x8B\x2A\x2A\x2A\x2A\x2A\x8D\x2A\x2A\x2A\x2A\x2A\x53\x33\x2A\x89"          /// SVC_PlayerInfo()                        [ 2020 HLDS ]   CS/ CZ
                ///
                "windows"           "\x55\x8B\x2A\x53\x8B\x2A\x2A\x56\x8B\x2A\x2A\x8B\x2A\x2A\x8B\x2A\x2A\x8D"  /// SVC_PlayerInfo()    ( sub_101BB5C0() )  [ 2023 HLDS ]   CS/ CZ
                ///
                "linux"             "@sv"
                "mac"               "@sv"
                ///
            }

            "realtime"              /// double              realtime
            {
                "library"           "engine"
                "windows"           "\xDC\x2A\x2A\x2A\x2A\x2A\xA1\x2A\x2A\x2A\x2A\x56"                          /// SV_CheckTimeouts()
                "linux"             "@realtime"
                "mac"               "@realtime"
            }

            "g_pGameRules"          /// CGameRules *        g_pGameRules
            {
                ///
                "library"           "server"
                ///
                /// "windows"       "\x8B\x2A\x2A\x2A\x2A\x2A\x85\x2A\x74\x2A\x8B\x2A\xFF\x2A\x2A\xA1"          /// StartFrame()                    [ 2020 HLDS ]   CS/ CZ
                ///
                "windows"           "\xA3\x2A\x2A\x2A\x2A\xFF\x2A\x2A\x2A\x2A\x2A\x85\x2A\x75\x2A\x33\x2A\xEB"  /// dword_10130BA0 @ sub_100C2440() [ 2023 HLDS ]   CS/ CZ
                ///
                "linux"             "@g_pGameRules"
                "mac"               "@g_pGameRules"
                ///
            }
        }
    }
}
```

- `/addons/amxmodx/data/gamedata/common.games/functions.engine.txt` (ONLY if your game server HAS this file)

```C++
/**
 * Do not edit this file.  Any changes will be overwritten by the gamedata
 * updater or by upgrading your AMX Mod X install.
 *
 * To override data in this file, create a subdirectory named "custom" and
 * place your own gamedata file(s) inside of it.  Such files will be parsed
 * after AMXX's own.
 *
 * For more information, see http://wiki.alliedmods.net/Gamedata_Updating_(AMX_Mod_X)
 */

"Games"
{
    "#default"
    {
        "Signatures"
        {
            "SV_DropClient"     /// void SV_DropClient(client_t *cl, qboolean crash, const char *fmt, ...);
            {
                "library"       "engine"
                ///
                /// "windows"   "\x55\x8B\x2A\x81\x2A\x2A\x2A\x2A\x2A\x8B\x2A\x2A\x53\x56\x8D"                                                                                                          /// [ HLDS 2020 ] CS/ CZ ( OLD )
                ///
                "windows"       "\x55\x8B\x2A\x81\x2A\x2A\x2A\x2A\x2A\xA1\x2A\x2A\x2A\x2A\x33\x2A\x89\x2A\x2A\x56\x57\x8B\x2A\x2A\x8D\x2A\x2A\x50\x33\x2A\x8D\x2A\x2A\x2A\x2A\x2A\x56\xFF\x2A\x2A\x68"  /// [ HLDS 2023 ] CS/ CZ ( NEW ) @ sub_101D1CB0()
                ///
                "linux"         "@SV_DropClient"
                "mac"           "@SV_DropClient"
            }

            "Cvar_DirectSet"    /// void Cvar_DirectSet(struct cvar_s *var, char *value);
            {
                "library"       "engine"
                ///
                /// "windows"   "\x55\x8B\x2A\x81\x2A\x2A\x2A\x2A\x2A\x56\x8B\x2A\x2A\x57\x8B\x2A\x2A\x85"                                                                                              /// [ HLDS 2020 ] CS/ CZ ( OLD )
                ///
                "windows"       "\x55\x8B\x2A\x81\x2A\x2A\x2A\x2A\x2A\xA1\x2A\x2A\x2A\x2A\x33\x2A\x89\x2A\x2A\x56\x8B\x2A\x2A\x57\x8B\x2A\x2A\x85\x2A\x0F\x2A\x2A\x2A\x2A\x2A\x85\x2A\x0F"              /// [ HLDS 2023 ] CS/ CZ ( NEW ) @ sub_101BDCF0()
                ///
                "linux"         "@Cvar_DirectSet"
                "mac"           "@Cvar_DirectSet"
            }
        }
    }
}
```
