// =========================================================================================================
//
//  CEHC - Crackman's Extra Huey Cargo Script
//  Version 1.0.2
//
//  Author: Crackman (dylanplecki@gmail.com) 
//
//	Born on United Operations (unitedoperations.net)
//
// ---------------------------------------------------------------------------------------------------------
//
//  v1.0.2
//  	FIXED: Turned off the ACE rotor backwash, which would cause players to rotate around and cough inside the huey
//
//  v1.0.1
//  	CHANGED: Made adding spawned Huey's to the list easier with the function '["globalHueyAddToList", [Spawned_Hueys]] call CBA_fnc_globalEvent;'
//
//  v1.0.0
//  	NEW: 2 Extra Slots in each Huey, on the sides
//  	NEW: Player can Get Out or Roll Out
//  	NEW: No player damage sustained if the player rolls out while the Huey is hovering under 8 feet ATL
//  	NEW: New hint to tell players how to get out of the huey
//  	NEW: Easily changable positions and animations
//  	NEW: Players will not see action if no seats are available
//  	NEW: Added fail-safe for player death in the huey
//
// ---------------------------------------------------------------------------------------------------------
//
//	Usage:
//		1. Put both the CRACK_mountHuey.sqf AND the CRACK_selfInteractMenu.sqf files in the "\scripts" folder
//		   in your mission directory
//
//		2. Add the next line to your INIT.sqf:
//		   nul = [] execVM "scripts\CRACK_mountHuey.sqf";
//
// ---------------------------------------------------------------------------------------------------------
//
//	Normal Syntax:
//		nul = [] execVM "scripts\CRACK_mountHuey.sqf";
//		(put in the mission's INIT.sqf file)
//
//	USE THIS LINE FOR ANY HUEY'S SPAWNED DURING THE MISSION:
//		["globalHueyAddToList", [Spawned_Hueys]] call CBA_fnc_globalEvent;
//
//	Examples:
//			This line can be put into a spawned Huey's INIT field:
//				["globalHueyAddToList", [this]] call CBA_fnc_globalEvent;
//
//			OR this line could be put into a script:
//				["globalHueyAddToList", [huey1, huey2, huey3, huey4]] call CBA_fnc_globalEvent;
//
//			OR this line could be put into a script:
//				["globalHueyAddToList", [_huey1, _huey2, _huey3, _huey4]] call CBA_fnc_globalEvent;
//
// ---------------------------------------------------------------------------------------------------------

// Privatizing (Certain) Variables
private ["_helo","_caller","_id"];

// Declaring Variables
if (count _this > 0) then {_helo = _this select 0;};
if (count _this > 1) then {_caller = _this select 1;};
if (count _this > 2) then {_id = _this select 2;};
if (isnil "CRACK_var_hueyHint") then {CRACK_var_huey_Hint = false;};

// Positions within huey for player placement, and respective animation strings
_positionarray = [[1.25,1.85,-1.3],[-1.25,1.85,-1.3]];
_directionarray = [90,270];
_animationarray = ["MH6_Cargo01","MH6_Cargo03"];

if (!isdedicated) then {waitUntil {!isNull player};};

// First-Run Code
if (count _this == 0) then {
	
	// Functions -------------------------------------------------------------------------------------------
	
	CRACK_fnc_globalHueyAnimation = {
		(_this select 0) switchmove (_this select 1);
	};
	
	CRACK_fnc_disableRotorBackwash = {
		
		_v = _this select 0;
		
		_isDustOn = _v getVariable ["ACE_sys_rotoreffects_duston", false];
		
		[_v] spawn {
			_v = _this select 0;
			waituntil {!(_v getVariable ["ACE_sys_rotoreffects_duston", false])};
			_v setVariable ["ACE_sys_rotoreffects_duston", true];
		};
		
		if (_isDustOn) then {
			
			if (((player distance _v) <= 25) AND (vehicle player == player)) then {
				hint "Please walk away from the Huey to stop coughing";
			};
			
			_v setVariable ["ACE_sys_rotoreffects_enginestate", false];
			
			_handle = [_v] spawn {
				_v = _this select 0;
				while {true} do {
					waituntil {(_v getVariable ["ACE_sys_rotoreffects_enginestate", false])};
					_v setVariable ["ACE_sys_rotoreffects_enginestate", false];
				};
			};
			
			sleep 4;
			
			terminate _handle;
			
			if (alive _v) then {
				if (isEngineOn _v) then {
					_v setVariable ["ACE_sys_rotoreffects_enginestate", true];
				} else {
					_v setVariable ["ACE_sys_rotoreffects_enginestate", false];
				};
			};
		};
	};
	
	CRACK_fnc_huey_addToList = {
		_hueys = _this;
		{
			if (_x iskindof "UH1H_base") then {
				if (isserver) then {
					if (((_x getvariable ["CRACK_huey_skid",[69]]) select 0) == 69) then {
						_x setvariable ["CRACK_huey_skid", [0,0], true];
					};
				};
				if (!isdedicated) then {
					if ((_x getvariable ["CRACK_huey_initialized",69]) == 69) then {
						waituntil {((_x getvariable ["CRACK_huey_skid",[69]]) select 0) != 69;};
						_x addaction ["Get On Side", "scripts\CRACK_mountHuey.sqf", 1, 9999, false, true, "", "((vehicle _this) == _this) AND (((_target getvariable 'CRACK_huey_skid') find 0) != -1) AND ((_this distance _target) <= 6.8)"];
						_x setvariable ["CRACK_huey_initialized", 1];
						// To disable ACE rotor backwash
						nul = [_x] spawn CRACK_fnc_disableRotorBackwash;
					};
				};
			};
		} foreach _hueys;
	};
	
	// End Functions ---------------------------------------------------------------------------------------
	
	// Registering CBA event handlers
	["globalHueyAnimation", CRACK_fnc_globalHueyAnimation] call CBA_fnc_addEventHandler;
	["globalHueyAddToList", CRACK_fnc_huey_addToList] call CBA_fnc_addEventHandler;
	
	// Getting all Hueys on Map
	_allVehicles = vehicles;
	_allHueys = [];
	{
		if (_x iskindof "UH1H_base") then {_allHueys = _allHueys + [_x];};
	} foreach _allVehicles;
	
	// Calling Huey Add To List
	_allHueys call CRACK_fnc_huey_addToList;
	
	if (isserver) then {
		// Nothing for server only (yet)
	};
	
	if (!isdedicated) then {
		
		// Initializing Variables
		CRACK_var_huey_playeronhuey = false;
		
		// Options for the ACE Self-Interact Menu
		["player", [ace_sys_interaction_key_self], -10, ["scripts\CRACK_selfInteractMenu.sqf", "main"]] call CBA_ui_fnc_add;
		
		// Functions ---------------------------------------------------------------------------------------
		
		CRACK_fnc_huey_chooseprimary = {
			if (count weapons player > 0) then
			{
			  private['_type', '_muzzles'];

			  _type = ((weapons player) select 0);
			  // check for multiple muzzles (eg: GL)
			  _muzzles = getArray(configFile >> "cfgWeapons" >> _type >> "muzzles");

			  if (count _muzzles > 1) then
			  {
				player selectWeapon (_muzzles select 0);
			  }
			  else
			  {
				player selectWeapon _type;
			  };
			};
		};
		
		CRACK_fnc_dismountHuey = {
			
			// Setting Variables
			_unit = "";
			if ((count _this) > 1) then {_unit = (_this select 1);} else {_unit = player;};
			_helo = CRACK_var_huey_Name;
			
			// Removing Huey Death Event Handler
			player removeMPEventHandler ["MPKilled",CRACK_var_huey_EHKilled];
			
			// Set Player on Huey variable to remove action and hint
			CRACK_var_huey_playeronhuey = false;
			hintsilent "";
			
			// Remove Player from Huey and play animation
			_dir = getdir _unit;
			_pos = getposASL _unit;
			_dismountDesiredPos = [((_pos select 0) + (sin(_dir) * .1)),((_pos select 1) + (cos(_dir) * .1)),((_pos select 2) - .5)];
			detach _unit;
			_unit setposASL _dismountDesiredPos;
			if ((alive _unit) AND ((_this select 0) != -1)) then {
				[_this select 0, _unit] spawn {
					_type = _this select 0;
					_unit = _this select 1;
					_animation = "";
					_safeDrop = false;
					switch (_type) do {
						case 0: {_animation = "AcrgPknlMstpSnonWnonDnon_AmovPercMstpSrasWrflDnon_getOutLow"; _safeDrop = false;};
						case 1: {_animation = "ActsPercMrunSlowWrflDf_FlipFlopPara"; _safeDrop = true;};
					};
					call CRACK_fnc_huey_chooseprimary;
					["globalHueyAnimation", [_unit, _animation]] call CBA_fnc_globalEvent;
					if (_safeDrop) then {
					_unit allowdamage false;
					sleep 1.3;
					_unit allowdamage true;
					};
				};
			};
			sleep .5;
			
			// Open slot for other players to embark
			_slots = _helo getvariable "CRACK_huey_skid";
			_slots set [CRACK_var_huey_slotindex, 0];
			_helo setvariable ["CRACK_huey_skid", _slots, true];
			
			// If the unit died, waituntil he respawns so we can delete his body
			if ((_this select 0) == -1) then {
				waituntil {sleep .1; alive player};
				deleteVehicle _unit;
			};
			
			// Add-back Action
			if (alive _helo) then {
				_helo addaction ["Get On Side", "scripts\CRACK_mountHuey.sqf", 1, 9999, false, true, "", "((vehicle _this) == _this) AND (((_target getvariable 'CRACK_huey_skid') find 0) != -1) AND ((_this distance _target) <= 6.8)"];
			};
		};
		
		// End Functions -----------------------------------------------------------------------------------
		
	};
} else {
	
	// Check to see if player is getting in
	if ((_this select 3) == 1) then {
		
		// Declaring Variables
		_caller = _this select 1;
		_id = _this select 2;
		
		// Getting Open/Used slots
		sleep (random(.15)); // Very bad coding, used so player has time to recieve variable if it changed
		CRACK_var_huey_slotindex = -1;
		
		// Finding Closest Side
		_slots_globalDis = [];
		_i = 0;
		{
			_slots_globalDis = _slots_globalDis + [[((getPosATL player) distance (_helo modelToWorld _x)), _i]];
			_i = _i + 1;
		} foreach _positionarray;
		
		// Sort Array by distance
		[_slots_globalDis, 0] call CBA_fnc_sortNestedArray;
		
		// Checking for open slots
		_slots = _helo getvariable "CRACK_huey_skid";
		{
			_index = _x select 1;
			if ((_slots select _index) == 0) exitwith {CRACK_var_huey_slotindex = _index;};
		} foreach _slots_globalDis;
		
		// If no slots are left, exitwith a hint
		if (CRACK_var_huey_slotindex == -1) exitwith {hint "There are no side slots left on the Huey's Side. Try to Get In normally";};
		
		// If slots are available, take a slot
		_slots set [CRACK_var_huey_slotindex,1];
		_helo setvariable ["CRACK_huey_skid", _slots, true];
		CRACK_var_huey_Name = _helo;
		
		// Remove Get In action for player
		_helo removeaction _id;
		CRACK_var_huey_playeronhuey = true;
		
		// Selecting corresponding position and animation for taken slot
		_position = _positionarray select CRACK_var_huey_slotindex;
		_direction = _directionarray select CRACK_var_huey_slotindex;
		_animation = _animationarray select CRACK_var_huey_slotindex;
		
		// Attaching player and setting Direction
		player attachTo [_helo, _position];
		sleep .1;
		player setdir _direction;
		
		// Playing Correct Animation
		["globalHueyAnimation", [player, _animation]] call CBA_fnc_globalEvent;
		
		// Workaround for now, so player doesn't start shooting like an idiot while on the side
		if !(player hasweapon "ace_safe") then {player addweapon "ace_safe"};
		player selectweapon "ace_safe";
		
		// Hint to use ACE self-interact menu
		_hintText = "<t color='#00E5EE' size='1.2' shadow='1' shadowColor='#000000' align='center'>NOTE:</t><br/><t align='center'>Use the </t><t color='#FCD116'>Get Out</t><t align='center'> or<br/></t><t color='#FCD116'>Roll Out</t><t align='center'> actions in your<br/></t><t color='#00CD00'>ACE Self-Interact Menu</t><t align='center'> to Dismount. Use </t><t color='#FCD116'>ALT</t><t align='center'> to look.</t>";
		if (!CRACK_var_huey_Hint) then {
			// Tell Player how to get out
			hint parseText (_hintText);
			
			// Make it a hintsilent from now on
			CRACK_var_huey_Hint = true;
		} else {
			// Tell Player how to get out
			hintsilent parseText (_hintText);
			
		};
		
		// EH to detect whether the player is dead and then remove body
		CRACK_var_huey_EHKilled = player addMPEventHandler ["MPKilled",{if (player == _this select 0) then {[-1, _this select 0, _this select 1] spawn CRACK_fnc_dismountHuey;};}];
		
	};
};