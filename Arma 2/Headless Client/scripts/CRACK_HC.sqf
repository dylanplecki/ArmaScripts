//   _    _                   _  _                      _____  _  _               _   
//  | |  | |                 | || |                    / ____|| |(_)             | |  
//  | |__| |  ___   __ _   __| || |  ___  ___  ___    | |     | | _   ___  _ __  | |_ 
//  |  __  | / _ \ / _` | / _` || | / _ \/ __|/ __|   | |     | || | / _ \| '_ \ | __|
//  | |  | ||  __/| (_| || (_| || ||  __/\__ \\__ \   | |____ | || ||  __/| | | || |_ 
//  |_|  |_| \___| \__,_| \__,_||_| \___||___/|___/    \_____||_||_| \___||_| |_| \__|
//                                                                                    
//				@ dylanplecki@gmail.com
//				@ forums.unitedoperations.net
//
//************************************************************************************
//
//	NOTES:
//
//----------------------------------------
//
//			Make sure you have a Headless Client Slot! Preferably use a side that
//			isn't a fighting force (ie. civilian or independent). The name of the
//			Headless Client can be set below in the parameters.
//
//----------------------------------------
//
//			IMPORTANT: Make sure you have at least 1 unit down on the editor for
//			each side that you want to spawn in via this script, ie. if you want
//			to spawn in some EAST units, you must first have an EAST unit set in
//			the editor.
//
//----------------------------------------
//
//			REMEMBER: Don't forget about the 144 Group limit! Try to have as many
//			units in one group as you can, and use the return value of the functions
//			to add to a cycle to delete empty groups (If you want to).
//
//----------------------------------------
//
//************************************************************************************
//
//	Syntaxes:
//
//----------------------------------------
//
//		_handle = [] execVM "scripts\CRACK_HC.sqf"; // Put in init.sqf, execute on all machines, initializes this script
//
//----------------------------------------
//
//		_result = _unitArray call CRACK_fnc_createGroupsOnHC; // Call on any (ONE) machine when you want to create (a) group(s) on the HC
//
//			Where:		_unitArray = [[[["UnitClassname1", "CodeToRunOnSpawn", _skill, _rank], ...], _position, _side], ...];
//
//			Returns:	Array (of spawned group names in order)
//				
//----------------------------------------
//
//************************************************************************************
//
//	Example Syntaxes:
//
//----------------------------------------
//
/*
	_unitArray = [
		[ // Group 1
			[ // Unit Array
				["TK_INS_Soldier_TL_EP1", "nul = [this, 'area0'] execVM 'scripts\UPSMON.sqf'", 0.5, "CORPORAL"],
				["TK_INS_Soldier_EP1", "", 0.2, "PRIVATE"],
				["TK_INS_Soldier_MG_EP1", "", 0.3, "PRIVATE"],
				["TK_INS_Soldier_AT_EP1", "", 0.3, "PRIVATE"]
			],
			(getMarkerPos "AI_SPAWN_1"),
			RESISTANCE
		],
		[ // Group 2
			[ // Unit Array
				["TK_INS_Soldier_TL_EP1", "nul = [this, 'area1'] execVM 'scripts\UPSMON.sqf'", 0.7, "SERGEANT"],
				["TK_INS_Soldier_Sniper_EP1", "", 0.5, "CORPORAL"]
			],
			(getMarkerPos "AI_SPAWN_2"),
			RESISTANCE
		]
	];
	_result = _unitArray call CRACK_fnc_createGroupsOnHC;
*/
//
//----------------------------------------
//
/*
	_unitArray = [
		[ // Group 1
			[ // Unit Array
				["TK_Soldier_SL_EP1", "", 0.7, "SERGEANT"],
				["TK_Soldier_B_EP1", "", 0.5, "CORPORAL"],
				["TK_Soldier_GL_EP1", "", 0.3, "PRIVATE"],
				["TK_Soldier_LAT_EP1", "", 0.3, "PRIVATE"],
				["TK_Soldier_MG_EP1", "", 0.3, "PRIVATE"],
				["TK_Soldier_B_EP1", "", 0.5, "CORPORAL"],
				["TK_Soldier_GL_EP1", "", 0.3, "PRIVATE"],
				["TK_Soldier_LAT_EP1", "", 0.3, "PRIVATE"],
				["TK_Soldier_MG_EP1", "", 0.3, "PRIVATE"],
				["TK_Soldier_Medic_EP1", "", 0.4, "PRIVATE"]
			],
			(getMarkerPos "hc_spawn"),
			EAST
		]
	];
	_result = _unitArray call CRACK_fnc_createGroupsOnHC;
*/
//
//----------------------------------------
//
//************************************************************************************

// Securing Variables
private ["_headlessClientNameString"];

//************************************************************************************

// Parameters
_headlessClientNameString = "HeadlessClient"; // Name of the Headless Client unit

//************************************************************************************

// Functions

//----------------------------------------

CRACK_fnc_createGroupsOnHC = {
	
	private ["_groups", "_spawnId"];
	
	_spawnId = CRACK_var_spawnIdCounter;
	CRACK_var_spawnIdCounter = CRACK_var_spawnIdCounter + 1;
	publicVariable "CRACK_var_spawnIdCounter";
	
	["CRACK_ceh_createGroupsOnHC", [_this, _spawnId]] call CBA_fnc_globalEvent;
	
	waituntil {(CRACK_var_spawnedGroups select 0) == _spawnId;};
	_groups = CRACK_var_spawnedGroups select 1;
	
	_groups
};

//----------------------------------------

CRACK_fnc_createGroups = {
	
	private ["_unitArray", "_spawnID", "_groups", "_position", "_units", "_group", "_side", "_type", "_code", "_skill", "_rank"];
	
	_unitArray = _this select 0;
	_spawnID = _this select 1;
	_groups = [];
	
	{ // FOREACH GROUP
		
		_units = _x select 0;
		_position = _x select 1;
		_side = _x select 2;
		_group = createGroup _side;
		
		{ // FOREACH UNIT IN GROUP
			_type = _x select 0;
			_code = _x select 1;
			_skill = _x select 2;
			_rank = _x select 3;
			
			_type createUnit [_position, _group, _code, _skill, _rank];
			
		} foreach _units;
		
		_groups = _groups + [_group];
		
	} foreach _unitArray;
	
	CRACK_var_spawnedGroups = [_spawnID, _groups];
	publicVariable "CRACK_var_spawnedGroups";
};

//----------------------------------------

//************************************************************************************

// Script

//----------------------------------------

if (isserver) then {
	
	CRACK_var_spawnIdCounter = 0;
	CRACK_var_spawnedGroups = [-1, []];
	
	publicVariable "CRACK_var_spawnIdCounter";
	publicVariable "CRACK_var_spawnedGroups";
	
};

//----------------------------------------

if (!isdedicated) then {
	
	waituntil {!(isNull player)};
	
	if ((str player) == _headlessClientNameString) then {
		
		["CRACK_ceh_createGroupsOnHC", CRACK_fnc_createGroups] call CBA_fnc_addEventHandler;
		
	};
};

//----------------------------------------

//************************************************************************************