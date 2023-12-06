# AQS

## Advanced Quake Sounds ##

Advanced Quake Sounds For AMX Mod X — **https://forums.alliedmods.net/**

**https://forums.alliedmods.net/showthread.php?t=152034**

## Installation ##

Upload **`AQS.ini`** to **`/addons/amxmodx/configs/`**

Upload **`AQS.amxx`** to **`/addons/amxmodx/plugins/`**

Upload **`AQS`** folder to **`/sound/`**

If **`CSTRIKE`** or **`CZERO`**, upload **`orpheu`** folder to **`/addons/amxmodx/configs/`**

If already running **`ReAPI`**, ignore **`Orpheu`** installation.

Download [Orpheu](https://github.com/Arkshine/Orpheu/releases).

Type **`AQS.amxx`** in **`/addons/amxmodx/configs/plugins.ini`**

## Pictures ##

**`CS/ CZ`**

![CS/ CZ](https://hattrick.go.ro/aqs-cscz.png)

**`DOD`**

![DOD](https://hattrick.go.ro/aqs-dod.png)

## Windows CS/ CZ AMX Mod X Game Data `g_pGameRules` Signatures ( *OLD* & *NEW* ) ##

- `/addons/amxmodx/data/gamedata/common.games/globalvars.engine.txt`

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
                "library"           "engine"
                "windows"           "\x8B\x2A\x2A\x2A\x2A\x2A\x8D\x2A\x2A\x2A\x2A\x2A\x53\x33\x2A\x89"          /// SVC_PlayerInfo()
                "linux"             "@sv"
                "mac"               "@sv"
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
                "windows"           "\xA3\x2A\x2A\x2A\x2A\xFF\x2A\x2A\x2A\x2A\x2A\x85\x2A\x75\x2A\x33\x2A\xEB"  /// dword_10130BA0 @ sub_100C2440   [ 2023 HLDS ]   CS/ CZ
                ///
                "linux"             "@g_pGameRules"
                "mac"               "@g_pGameRules"
                ///
            }
        }
    }
}
```
