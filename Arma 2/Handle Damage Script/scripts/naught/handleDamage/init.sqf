/*******************************************************************************
	
	Version:		1.0
	Name:			UOTC Handle Damage Script
	Author:			Naught (dylanplecki@gmail.com)
	Website:		UnitedOperations.Net
	
	Description:	A custom damage handler for training purposes.
	Usage:			1) Add this next line to your init.sqf (for all machines):
						foo = [] execVM "scripts\naught\handleDamage\init.sqf";
					2) Add this next line to your description.ext:
						#include "scripts\naught\handleDamage\rsc\diag_init.hpp"
	Parameters:		None.
	Return Value:	None.
	
	Notes:			- Default values can be changed in defaults.sqf
					- Strings can be changed in the stringtable.csv
					- Individual settings can be changed in-game via the ACE
					  interact and self-interact menus.

*******************************************************************************/

cm_handleDamage = true;
cm_handleDamageDebug = false;

// Generic/static variables
cm_handleDamage_dic_bodyParts		= ["", "head_hit", "body", "hands", "legs"];
cm_handleDamage_dic_bodyPartNames	= [(localize "STR_BODY_ALL"), (localize "STR_BODY_HEAD"), (localize "STR_BODY_BODY"), (localize "STR_BODY_HANDS"), (localize "STR_BODY_LEGS")];
cm_handleDamage_dft_localDamArray	= [0,0,0,0,0,0]; // [dam_Overall, dam_Head, dam_Body, dam_Hands, dam_Legs, lastTimeStamp]
cm_handleDamage_interactMenu = [];

// Needed for this script
if (!isNil "ace_sys_wounds_enabled" OR !ace_sys_wounds_enabled) then {
	ace_sys_wounds_enabled = true;
};

// Load Functions
cm_handleDamage_fnc_aceInteract		= compile preProcessFileLineNumbers "scripts\naught\handleDamage\f\fnc_aceInteract.sqf";
cm_handleDamage_fnc_addHit			= compile preProcessFileLineNumbers "scripts\naught\handleDamage\f\fnc_addHit.sqf";
cm_handleDamage_fnc_handleDamage	= compile preProcessFileLineNumbers "scripts\naught\handleDamage\f\fnc_handleDamage.sqf";
cm_handleDamage_fnc_onDeath			= compile preProcessFileLineNumbers "scripts\naught\handleDamage\f\fnc_onDeath.sqf";
cm_handleDamage_fnc_onSpawn			= compile preProcessFileLineNumbers "scripts\naught\handleDamage\f\fnc_onSpawn.sqf";

// Load Handle Damage Scripts (HDS)
call compile preProcessFileLineNumbers "scripts\naught\handleDamage\hds\load.sqf";

// Waituntil ACE Wounds addon is loaded
waitUntil {!isNil "ace_sys_wounds" AND ace_sys_wounds};

// Add player variables/scripts
if (!isDedicated) then {
	
	private ["_acehdeh"];
	
	waitUntil {!isNull player};
	
	player setVariable ["cm_handleDamage", true, true];
	
	// Load Defaults
	call compile preProcessFileLineNumbers "scripts\naught\handleDamage\defaults.sqf";
	
	cm_handleDamage_localDamArray = [0,0,0,0,0,0];
	_unit setVariable ["cm_handleDamage_localDamArray", cm_handleDamage_localDamArray, true];
	
	[player] call cm_handleDamage_fnc_onSpawn;
	
	waitUntil {
		_acehdeh = player getVariable ["ace_sys_wounds_hdeh", "T"];
		typeName(2) == typeName(_acehdeh);
	};
	
	player removeEventHandler ["handleDamage", _acehdeh];
	cm_handleDamage_hdEH = player addEventHandler ["HandleDamage", cm_handleDamage_fnc_handleDamage];
	
	cm_handleDamage_kdEH = player addEventHandler ["killed", cm_handleDamage_fnc_onDeath];
	
	["player", [ace_sys_interaction_key_self], -100000, ["_this call cm_handleDamage_fnc_aceInteract", "main"]] call CBA_ui_fnc_add;
	[["Man"], [ace_sys_interaction_key], -100000, ["_this call cm_handleDamage_fnc_aceInteract", "main"]] call CBA_ui_fnc_add;
};