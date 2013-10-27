//   _____   _____                _____   _  __        ____    _____    ____               _______ 
//  / ____| |  __ \      /\      / ____| | |/ /       / __ \  |  __ \  |  _ \      /\     |__   __|
// | |      | |__) |    /  \    | |      | ' /       | |  | | | |__) | | |_) |    /  \       | |   
// | |      |  _  /    / /\ \   | |      |  <        | |  | | |  _  /  |  _ <    / /\ \      | |   
// | |____  | | \ \   / ____ \  | |____  | . \       | |__| | | | \ \  | |_) |  / ____ \     | |   
//  \_____| |_|  \_\ /_/    \_\  \_____| |_|\_\       \____/  |_|  \_\ |____/  /_/    \_\    |_|   
//
//*************************************************************************************************
//
// Initialization File
//
//*************************************************************************************************
#include "f\script_macros.hpp"

// DISABLE ACE MEDICAL EXTRA SUPPLIES + AI MEDICAL FOR PERFORMANCE
ace_sys_wounds_no_medical_gear = true;
ace_sys_wounds_noai = true;

// Settings
_settings = call compile preprocessfilelinenumbers defDir(settings.sqf);
_ORBATParams = _settings select 0;
_teamRosterParams = _settings select 1;

// Function Initialization
CRACK_fnc_addMagArray = compile preprocessfilelinenumbers defDir(f\fnc_addMagArray.sqf);
CRACK_fnc_addEarProtection = compile preprocessfilelinenumbers defDir(f\fnc_addEarProtection.sqf);
CRACK_fnc_addRuckMagArray = compile preprocessfilelinenumbers defDir(f\fnc_addRuckMagArray.sqf);
CRACK_fnc_addRuckWepArray = compile preprocessfilelinenumbers defDir(f\fnc_addRuckWepArray.sqf);
CRACK_fnc_selectPrimaryWep = compile preprocessfilelinenumbers defDir(f\fnc_selectPrimaryWep.sqf);
CRACK_fnc_rucksackOperations = compile preprocessfilelinenumbers defDir(f\fnc_rucksackOperations.sqf);
CRACK_fnc_setLoadout = compile preprocessfilelinenumbers defDir(f\fnc_setLoadout.sqf);

// Waiting for the player to join the game
if (!isdedicated) then {
	waitUntil {!isNull player};
};

// Team Roster Script Initialization
if (!isdedicated AND (_teamRosterParams select 0)) then {nul = _teamRosterParams execVM defDir(scripts\team_roster\team_roster.sqf);};

// ORBAT Initialization
nul = _ORBATParams execVM defDir(ORBATS\init.sqf);

