//
// Boomerang Script - A Shot Detection System
//		v1.1 - By Crackman
//
//-----------------------------------------------
//
// Instructions:
//		1. Add this line to your init.sqf:
//			nul = [] execVM "scripts\boomerang\init.sqf";
//
//		2. Add this line to your description.ext:
//			#include "scripts\boomerang\rsc\resources.hpp"
//
//		3. Add this line to any AI's init who
//		   can use the ammo specified below:
//			nul = [this] call CRACK_sf_fnc_addUnit;
//
//		4. Change the Variables below! Especially
//		   CRACK_sf_vehicleArray, which is
//		   mission specific.
//
//-----------------------------------------------

private ["_varArray"];

// Macros
#include "f\x-macros.hpp"

// DEBUG SYSTEM
//-------------
// 6 - All
// 5 - Info
// 4 - Notice
// 3 - Warning
// 2 - Error
// 1 - Critical
CRACK_sf_debugEnabled = [false, 4]; // [Enabled, Level(1,2,3,4,5,6)]

// Delay Start for Debugging Purposes
ifDebug(0) then {
	sleep 2;
};

// Variables
debugChat("Variables Processing",5);

if (isServer) then { // So it can be changed in Runtime
	
	CRACK_sf_maxDetectionRad = 2400; // Max Detection Radius for Boomerang
	publicVariable "CRACK_sf_maxDetectionRad";
	
	CRACK_sf_minDetectionRad = 10; // Min Detection Radius for Boomerang
	publicVariable "CRACK_sf_minDetectionRad";
	
	CRACK_sf_vehicleArray = []; // Vehicles Equipped with Boomerang
	publicVariable "CRACK_sf_vehicleArray";
	
	CRACK_sf_ammoArray = [  // Ammuntion Types that will set-off Boomerang
		"R_PG7V_AT","R_PG7VL_AT","ACE_R_PG7VM_AT","R_PG7VR_AT","R_PG9_AT","ACE_Rocket_PG29","ACE_R_TBG7V_AT","ACE_Rocket_TBG29","Sh_125_SABOT","Sh_125_HE","R_RPG18_AT",
		"ACE_Rocket_RPG22","ACE_Rocket_RMG","ACE_Rocket_RPG27","ACE_R_M72_AT","ACE_R_M136_CSRS","ACE_R_RPOM","ACE_Rocket_RSHG1","M_Igla_AA","ACE_OG15VRound",
		"ACE_PG15VRound","ACE_3BK18Round","ACE_3BK29Round","ACE_3BM17MRound","Sh_125_HE","Sh_125_HE"
	];
	publicVariable "CRACK_sf_ammoArray";
	
	CRACK_sf_shotFired = []; // [unit, position, direction, ammo, affected_vehicles]
	publicVariable "CRACK_sf_shotFired";
	
	CRACK_sf_dirConeSize = (120 / 2); // Variable should be one half of the cone angle in degrees
	publicVariable "CRACK_sf_dirConeSize";
	
	_varArray = ["CRACK_sf_shotFired", "CRACK_sf_maxDetectionRad", "CRACK_sf_vehicleArray", "CRACK_sf_ammoArray", "CRACK_sf_dirConeSize", "CRACK_sf_minDetectionRad", "CRACK_sf_debugEnabled"];
};

// Static Variables
CRACK_sf_defaultVehVar = [true, true, true];
CRACK_sf_logBoomerangActs = false;

debugChat("Functions Processing",5);

// Functions
CRACK_sf_fnc_addUnit =				compile preprocessFileLineNumbers "scripts\boomerang\f\fnc_addUnit.sqf";
CRACK_sf_fnc_dirTo =				compile preprocessFileLineNumbers "scripts\boomerang\f\fnc_dirTo.sqf";
CRACK_sf_fnc_getQuadrant =			compile preprocessFileLineNumbers "scripts\boomerang\f\fnc_getQuadrant.sqf";
CRACK_sf_fnc_interact =				compile preprocessFileLineNumbers "scripts\boomerang\f\fnc_interact.sqf";
CRACK_sf_fnc_setBoomerangStatus =	compile preprocessFileLineNumbers "scripts\boomerang\f\fnc_setBoomerangStatus.sqf";
CRACK_sf_fnc_shotAlert =			compile preprocessFileLineNumbers "scripts\boomerang\f\fnc_shotAlert.sqf";
CRACK_sf_fnc_shotFiredLocal =		compile preprocessFileLineNumbers "scripts\boomerang\f\fnc_shotFiredLocal.sqf";
CRACK_sf_fnc_shotFiredRemote =		compile preprocessFileLineNumbers "scripts\boomerang\f\fnc_shotFiredRemote.sqf";
CRACK_sf_fnc_simpDeg =				compile preprocessFileLineNumbers "scripts\boomerang\f\fnc_simpDeg.sqf";

// Script
if (!isDedicated) then {
	
	private ["_result", "_newTime", "_timedOut"];
	
	debugChat("Variables Processing",5);
	
	// 60 Second Timeout
	_newTime = time + 60;
	
	waituntil {
		_result = true;
		{
			if (isNil _x) exitWith {_result = false;};
		} forEach _varArray;
		_timedOut = (time > _newTime);
		_result OR _timedOut;
	};
	
	debugChatC("Variable Check Timed-Out",1,_timedOut);
	debugChat("Adding Public Event Handler",5);
	
	"CRACK_sf_shotFired" addPublicVariableEventHandler {
		foo = (_this select 1) call CRACK_sf_fnc_shotFiredRemote;
	};
	
	debugChat("Adding Player to Script",5);
	
	CRACK_sf_playerFEH = [player] call CRACK_sf_fnc_addUnit;
	
	debugChat("Adding ACE Interact Key for Vehicles",5);
	
	["player", [ace_sys_interaction_key], -99999, ["_this call CRACK_sf_fnc_interact;", "main"]] call CBA_ui_fnc_add;
	
	debugChat("Init Processing Done",4);
};