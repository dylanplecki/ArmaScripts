//     _____                               _              _____           _       _   
//    / ____|                             | |            / ____|         (_)     | |  
//   | (___  _   _ _ __ _ __ ___ _ __   __| | ___ _ __  | (___   ___ _ __ _ _ __ | |_ 
//    \___ \| | | | '__| '__/ _ \ '_ \ / _` |/ _ \ '__|  \___ \ / __| '__| | '_ \| __|
//    ____) | |_| | |  | | |  __/ | | | (_| |  __/ |     ____) | (__| |  | | |_) | |_ 
//   |_____/ \__,_|_|  |_|  \___|_| |_|\__,_|\___|_|    |_____/ \___|_|  |_| .__/ \__|
//                                                                         | |        
//          v1.1 - By Crackman                                             |_|        
//				@ dylanplecki@gmail.com
//				@ forums.unitedoperations.net
//
//************************************************************************************
//
//	Syntax:
//
//		nul = [] execVM "scripts\surrender\init.sqf"; // Put in init.sqf, execute on all machines
//
//************************************************************************************
#include "f\defines.hpp"
//************************************************************************************
// Parameters

GVAR(cyanide) = true; // Allow player to take Cyanide (kill himself) when surrendered (DEFAULT: true)
GVAR(surrenderHintRadius) = 15; // Radius which to tell enemies that a unit is surrendering (DEFAULT: 15)
GVAR(runAwayHintRadius) = 25; // Radius which to tell enemies that a unit is running away(, also least distance to enemies to run away) (DEFAULT: 25)
GVAR(surrenderAnimation) = "AmovPercMstpSsurWnonDnon"; // Animation unit will play when surrendering, uses playmove (DEFAULT: "AmovPercMstpSsurWnonDnon")

//************************************************************************************
// Functions

PREPFUNC(capture);
PREPFUNC(disableWeapons);
PREPFUNC(findInNestedArray);
PREPFUNC(getNearEnemies);
PREPFUNC(hintSurrender);
PREPFUNC(interact);
PREPFUNC(onPlayerDeath);
PREPFUNC(releaseUnit);
PREPFUNC(removeAllActions);
PREPFUNC(removeFromNestedArray);
PREPFUNC(removeWeaponsAndMagsToCache);
PREPFUNC(runAway);
PREPFUNC(selfInteract);
PREPFUNC(surrender);
PREPFUNC(takeCyanide);

//************************************************************************************
// Some Variables

GVAR(codeStringAceSelfInteract) = format["_this call %1", QUOTE(FUNC(selfInteract))];
GVAR(codeStringAceInteract) = format["_this call %1", QUOTE(FUNC(interact))];
GVAR(surrenderActionIndexes) = [];
GVAR(playerIsTakingCyanide) = false;

//************************************************************************************
// Script

if (!isdedicated) then {
	
	GVAR(surrenderActionIndexes) = [];

	["CRACK_ceh_hintSurrender", FUNC(hintSurrender)] call CBA_fnc_addEventHandler;
	["CRACK_ceh_releaseUnit", FUNC(releaseUnit)] call CBA_fnc_addEventHandler;
	
	waituntil {!(isNull player)};
	
	GVAR(EHID_surrenderScript) = player addMPEventHandler ["MPKilled", {_this call FUNC(onPlayerDeath);}];
	
	player setvariable [QUOTE(GVAR(surrenderedStatus)), [false, false], true]; // [surrendered, captured], CHANGE HERE IF NEED BE
	
	["player", [ace_sys_interaction_key_self], 10000, [GVAR(codeStringAceSelfInteract), "main"]] call CBA_ui_fnc_add; // Self-Interact Menu
	
	[["Man"], [ace_sys_interaction_key], -999999, [GVAR(codeStringAceInteract), "main"]] call CBA_ui_fnc_add; // Interact Menu
};