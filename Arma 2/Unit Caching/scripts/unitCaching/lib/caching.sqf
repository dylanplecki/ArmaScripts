/*
	Title: Caching Library
	Author: Dylan Plecki (Naught)
	
	License:
		Copyright © 2013 Dylan Plecki. All rights reserved.
		Except where otherwise noted, this work is licensed under CC BY-NC-ND 4.0,
		available for reference at <http://creativecommons.org/licenses/by-nc-nd/4.0/>.
*/

#define IS_MAGAZINE(magName) isClass(configFile >> "CfgMagazines" >> magName)
#define IS_WEAPON(wepName) isClass(configFile >> "CfgWeapons" >> wepName)

/*
	Group: Caching Objects
*/

CLASS("UCD_obj_cachedObject")
	PROTECTED VARIABLE("code","properties"); // Instance of "UCD_obj_hashMap" object
	PUBLIC FUNCTION("","constructor") {
		private ["_prop"];
		_prop = ["new"] call UCD_obj_hashMap;
		MEMBER("properties",_prop);
	};
	PUBLIC FUNCTION("","deconstructor") {
		DELETE_VARIABLE("properties");
	};
	PUBLIC FUNCTION("array","insert") {
		["insert", _this] call MEMBER("properties",nil);
	};
	PUBLIC FUNCTION("string","get") {
		["get", _this] call MEMBER("properties",nil);
	};
	PUBLIC FUNCTION("array","get") {
		["get", _this] call MEMBER("properties",nil);
	};
	PUBLIC FUNCTION("string","erase") {
		["get", _this] call MEMBER("properties",nil);
	};
	PUBLIC FUNCTION("","copy") {
		["copy"] call MEMBER("properties",nil);
	};
	PUBLIC FUNCTION("array","copy") {
		["copy", _this] call MEMBER("properties",nil);
	};
ENDCLASS;

CLASS_EXTENDS("UCD_obj_cachedAsset","UCD_obj_cachedObject")
	PUBLIC FUNCTION("object","constructor") {
		private ["_params"];
		_params = [_this, false, {GLOBAL_SPAWN_DISTANCE}];
		MEMBER("constructor",_params);
	};
	PUBLIC FUNCTION("array","constructor") {
		private ["_obj", "_savePos", "_spawnDis", "_prop"];
		_obj = _this select 0;
		_savePos = DEFAULT_PARAM(1,false);
		_spawnDis = DEFAULT_PARAM(2,{GLOBAL_SPAWN_DISTANCE});
		_prop = ["new"] call UCD_obj_hashMap;
		/* Optimized non-member inserts */
		["insert", ["type", (typeOf _obj)]] call _prop;
		["insert", ["position", (getPos _obj)]] call _prop;
		["insert", ["spawnDis", _spawnDis]] call _prop;
		["insert", ["spawnPos", _savePos]] call _prop;
		["insert", ["vectorDir", (vectorDir _obj)]] call _prop;
		["insert", ["vectorUp", (vectorUp _obj)]] call _prop;
		["insert", ["velocity", (velocity _obj)]] call _prop;
		["insert", ["vehicleVarName", (vehicleVarName _obj)]] call _prop;
		if (_obj isKindOf "Man") then {
			/* Unit magazine workaround */
			private ["_magazines"];
			_magazines = magazines _obj;
			if (IS_MAGAZINE(currentMagazine _obj)) then {
				_magazines set [count _magazines, currentMagazine _obj];
			};
			["insert", ["group", (group _obj)]] call _prop;
			["insert", ["weapons", (weapons _obj)]] call _prop;
			["insert", ["magazines", _magazines]] call _prop;
			["insert", ["skill", (skill _obj)]] call _prop;
			["insert", ["rank", (rank _obj)]] call _prop;
			if ((vehicle _obj) != _obj) then {
				["insert", ["vehicle", (vehicle _obj)]] call _prop;
				["insert", ["unitVehPos", (_obj call UCD_fnc_unitVehPos)]] call _prop;
			};
			if (CHECK_MOD("ace")) then {
				["insert", ["ruckWeps", [_obj] call ACE_fnc_RuckWeaponsList]] call _prop;
				["insert", ["ruckMags", [_obj] call ACE_fnc_RuckMagazinesList]] call _prop;
				["insert", ["wob", [_obj] call ACE_fnc_WeaponOnBackName]] call _prop;
			};
		} else {
			["insert", ["isVehicle", true]] call _prop;
			["insert", ["weaponCargo", (getWeaponCargo _obj)]] call _prop;
			["insert", ["magazineCargo", (getMagazineCargo _obj)]] call _prop;
		};
		MEMBER("properties",_prop);
		deleteVehicle _obj;
	};
	PUBLIC FUNCTION("","spawn") {
		private ["_params"];
		_params = [0,0,0];
		MEMBER("spawn",_params);
	};
	PUBLIC FUNCTION("array","spawn") {
		private ["_prop", "_pos", "_obj"];
		_prop = MEMBER("properties",nil);
		_pos = if (["get", ["spawnPos", false]] call _prop) then { // Force spawn at set position
			["get", "position"] call _prop;
		} else {_this};
		if (!(["get", ["isVehicle", false]] call _prop)) then { // Unit
			_obj = (["get", ["group", grpNull]] call _prop) createUnit [
				(["get", "type"] call _prop),
				_pos,
				[],
				100,
				"NONE" // Switched from "FORM" due to positional discrepencies
			];
			_obj setSkill (["get", ["skill", 0.5]] call _prop);
			_obj setRank (["get", ["rank", "PRIVATE"]] call _prop);
			{_obj removeMagazine _x} forEach (magazines _obj);
			removeAllItems _obj;
			removeAllWeapons _obj;
			removeBackpack _obj;
			{ // forEach
				_obj addMagazine _x; // This creates "No owner" error spam in RPT for some reason
			} forEach (["get", ["magazines", []]] call _prop);
			{ // forEach
				_obj addWeapon _x;
			} forEach (["get", ["weapons", []]] call _prop);
			if (CHECK_MOD("ace")) then {
				{ // forEach
					[_obj, (_x select 0), (_x select 1)] call ACE_fnc_PackWeapon;
				} forEach (["get", ["ruckWeps", []]] call _prop);
				{ // forEach
					[_obj, (_x select 0), (_x select 1)] call ACE_fnc_PackMagazine;
				} forEach (["get", ["ruckMags", []]] call _prop);
				_obj setVariable ["ACE_weapononback", (["get", ["wob", ""]] call _prop), true];
			};
			private ["_veh"];
			_veh = ["get", "vehicle"] call _prop;
			if (!isNil "_veh" && {!isNull _veh} && {alive _veh}) then {
				private ["_unitVehPos"];
				_unitVehPos = ["get", ["unitVehPos", [""]]] call _prop;
				switch (_unitVehPos select 0) do {
					case "Commander": {_obj moveInCommander _veh};
					case "Gunner": {_obj moveInGunner _veh};
					case "Driver": {_obj moveInDriver _veh};
					case "Turret": {_obj moveInTurret [_veh, (_unitVehPos select 1)]};
					case "Cargo": {_obj moveInCargo _veh};
				};
			};
		} else { // Vehicle
			_obj = (["get", "type"] call _prop) createVehicle _pos;
			private ["_wepCargo", "_magCargo"];
			_wepCargo = ["get", ["weaponCargo", []]] call _prop;
			_magCargo = ["get", ["magazineCargo", []]] call _prop;
			{ // forEach
				_obj addWeaponCargoGlobal [_x, ((_wepCargo select 1) select _forEachIndex)];
			} forEach (_wepCargo select 0);
			{ // forEach
				_obj addMagazineCargoGlobal [_x, ((_magCargo select 1) select _forEachIndex)];
			} forEach (_magCargo select 0);
		};
		private ["_varName"];
		_varName = ["get", ["vehicleVarName", ""]] call _prop;
		if (_varName != "") then {
			_obj setVehicleVarName _varName;
			missionNamespace setVariable [_varName, _obj];
			UCD_setVehicleVarNameRemote = [_obj, _varName];
			publicVariable "UCD_setVehicleVarNameRemote";
			publicVariable _varName;
		};
		if (["get", ["spawnPos", false]] call _prop) then {
			_obj setVectorDir (["get", "vectorDir"] call _prop);
			_obj setVectorUp (["get", "vectorUp"] call _prop);
			_obj setVelocity (["get", "velocity"] call _prop);
		};
		_obj call UCD_spawnUnitInit;
		_obj
	};
ENDCLASS;

/*
	Group: Caching Functions
*/

UCD_fnc_cacheObject = {
	CHECK_THIS;
	private ["_obj"];
	_obj = _this select 0;
	waitUntil {!isNull _obj};
	if (alive _obj && {local _obj} && {!isPlayer _obj}) then {
		waitUntil {!isNull (group _obj)};
		private ["_group"];
		_group = group _obj;
		/* Setup group caching */
		if (isNil {_group getVariable ["UCD_monitorScript", nil]}) then {
			_group setVariable ["UCD_monitorScript", ([_group] spawn UCD_fnc_cacheMonitor)];
		};
		/* Wait for unit to be cacheable */
		private ["_cache", "_cacheStats"];
		_cache = false;
		_cacheStats = ["", false, false, -1];
		while {!_cache} do {
			if (isNull _obj || {!alive _obj} || {!local _obj}) exitWith {};
			{ // forEach
				if (_obj isKindOf (_x select 0)) exitWith {
					_cacheStats = _x;
				};
			} forEach UCD_cacheList;
			if ((_cacheStats select 1) && // Allowed to cache in config
				{_obj getVariable ["cacheObject", true]} && // Not marked for no caching
				{!(_obj isKindOf "Man") || {_obj != (leader _obj)}} && // Either a vehicle or not the leader of the group
				{([_obj] call UCD_fnc_closestPlayerDis) > (call (_cacheStats select 3))} // Farther away from players than the specified min distance
			) exitWith {_cache = true}; // Then start caching
			uisleep CACHE_MONITOR_DELAY;
		};
		/* Cache object (if applicable) */
		if (_cache) then {
			private ["_cacheObj"];
			_cacheObj = false;
			if (_obj isKindOf "Man") then { // Unit
				_unitVehPos = _obj call UCD_fnc_unitVehPos;
				{ // forEach
					if ((_x select 0) == (_unitVehPos select 0)) exitWith { // Reiterate cache stack for vehicle position
						_cacheStats = _x;
					};
				} forEach UCD_cacheList;
				if (_cacheStats select 1) then {
					_cacheObj = true;
				};
			} else { // Vehicle
				if ((count (crew _obj)) > 0) then { // Assume all crew will automatically cache
					private ["_group", "_endWait", "_res"];
					_group = group ((crew _obj) select 0);
					_endWait = diag_tickTime + CACHE_VEH_TIMEOUT;
					_res = false;
					while {true} do {
						if (isNull _obj || {!alive _obj} || {!local _obj}) exitWith {}; // Exit with failure
						_res = (count (crew _obj)) == 0;
						if (_res || {diag_tickTime > _endWait}) exitWith {}; // Final exit check, only possibility of true
						uisleep CACHE_MONITOR_DELAY;
					};
					if (_res) then {
						_cacheObj = true;
					};
				} else {_cacheObj = true};
			};
			if (_cacheObj) then { // Final caching of object
				[_group, "UCD_cachedObjects", (["new", [_obj, (_cacheStats select 2), (_cacheStats select 3)]] call UCD_obj_cachedAsset)] call UCD_fnc_push;
			};
		};
	};
};

UCD_fnc_cacheMonitor = {
	CHECK_THIS;
	private ["_group"];
	_group = _this select 0;
	_group allowFleeing 0; // Unfortunate fix for fleeing units due to caching
	uisleep 1; // Allow group members to load and cache if needed
	waitUntil {!isNil "UCD_serverInit"}; // Wait for server init to process
	while {!(isNil "_group") && {!isNull _group} && {(count (units _group)) >= 0} && {!isNil {_group getVariable ["UCD_monitorScript", nil]}}} do {
		/* Recheck all cached and non-cached objects for changes */
		private ["_cachedObjects", "_nonCachedObjects"];
		_cachedObjects = _group getVariable ["UCD_cachedObjects", []];
		_nonCachedObjects = [];
		if ((count _cachedObjects) > 0) then {
			/* Check each cached object */
			private ["_minDis"];
			_minDis = [leader _group] call UCD_fnc_closestPlayerDis;
			if (_minDis >= 0) then {
				{ // forEach
					if ((call (["get", ["spawnDis", 0]] call _x)) >= _minDis) then {
						_nonCachedObjects = _nonCachedObjects + [_x];
						_cachedObjects set [_forEachIndex, objNull];
					};
				} forEach _cachedObjects;
			};
		};
		_cachedObjects = _cachedObjects - [objNull];
		/* Spawn previously cached objects */
		{ // forEach
			["spawn", (getPos (leader _group))] call _x;
			["delete", _x] call UCD_obj_cachedAsset;
		} forEach _nonCachedObjects;
		/* Reset group variable to currently cached objects */
		_group setVariable ["UCD_cachedObjects", _cachedObjects];
		/* Checking AI distribution methods */
		if (isServer && {!isNil "UCD_distributeAI"} && {!isNil "UCD_headlessClients"} && // Distribution library is present and working
			{UCD_distributeAI && {(count UCD_headlessClients) > 0} && {local (leader _group)}} // HC distribution is present and allowed
		) exitWith { // Stop current execution and transfer
			private ["_hc"];
			_hc = UCD_headlessClients select random((count UCD_headlessClients) - 1); // Equal probability distribution?
			[_group, (_hc select 1)] call UCD_fnc_sendGroup; // Note: requires distribution library
		};
		uisleep CACHE_MONITOR_DELAY;
	};
	_group setVariable ["UCD_monitorScript", nil];
};

UCD_fnc_setVehicleVarName = {
	CHECK_THIS;
	private ["_val", "_veh", "_varName"];
	_val = if (typeName(_this select 0) == "STRING") then {_this select 1} else {_this}; // Differentiate between normal and PVEH call
	_veh = _val select 0;
	_varName = _val select 1;
	_veh setVehicleVarName _varName;
	// Global variable value is publicVariable'd in prior code to conform with JIPs
};

/*
	Group: Initialization Code
*/

"UCD_setVehicleVarNameRemote" addPublicVariableEventHandler UCD_fnc_setVehicleVarName;

if (isServer) then {
	UCD_spawnUnitInit = CACHE_UNIT_SPAWN_FNC;
	UCD_distributeAI = CACHE_DISTRIBUTE_AI;
	publicVariable "UCD_distributeAI";
	publicVariable "UCD_spawnUnitInit";
};
