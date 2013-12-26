/*
	Title: Caching Library
	Author: Dylan Plecki (Naught)
	
	License:
		Copyright © 2013 Dylan Plecki. All rights reserved.
		Except where otherwise noted, this work is licensed under CC BY-NC-ND 4.0,
		available for reference at <http://creativecommons.org/licenses/by-nc-nd/4.0/>.
*/

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
		private ["_unit", "_savePos", "_spawnDis", "_prop"];
		_unit = _this select 0;
		_savePos = DEFAULT_PARAM(1,false);
		_spawnDis = DEFAULT_PARAM(2,{GLOBAL_SPAWN_DISTANCE});
		_prop = ["new"] call UCD_obj_hashMap;
		/* Optimized non-member inserts */
		["insert", ["type", (typeOf _unit)]] call _prop;
		["insert", ["position", (getPos _unit)]] call _prop;
		["insert", ["spawnDis", _spawnDis]] call _prop;
		["insert", ["spawnPos", _savePos]] call _prop;
		["insert", ["position", (getPos _unit)]] call _prop;
		["insert", ["vectorDir", (vectorDir _unit)]] call _prop;
		["insert", ["vectorUp", (vectorUp _unit)]] call _prop;
		["insert", ["velocity", (velocity _unit)]] call _prop;
		["insert", ["vehicleVarName", (vehicleVarName _unit)]] call _prop;
		if (_unit isKindOf "Man") then {
			["insert", ["group", (group _unit)]] call _prop;
			["insert", ["weapons", (weapons _unit)]] call _prop;
			["insert", ["magazines", (magazines _unit + [currentMagazine _unit])]] call _prop;
			["insert", ["skill", (skill _unit)]] call _prop;
			["insert", ["rank", (rank _unit)]] call _prop;
			if ((vehicle _unit) != _unit) then {
				["insert", ["vehicle", (vehicle _unit)]] call _prop;
				["insert", ["unitVehPos", (_unit call UCD_fnc_unitVehPos)]] call _prop;
			};
			if (CHECK_MOD("ace")) then {
				["insert", ["ruckWeps", [_unit] call ACE_fnc_RuckWeaponsList]] call _prop;
				["insert", ["ruckMags", [_unit] call ACE_fnc_RuckMagazinesList]] call _prop;
				["insert", ["wob", [_unit] call ACE_fnc_WeaponOnBackName]] call _prop;
			};
		} else {
			["insert", ["isVehicle", true]] call _prop;
			["insert", ["weaponCargo", (getWeaponCargo _unit)]] call _prop;
			["insert", ["magazineCargo", (getMagazineCargo _unit)]] call _prop;
		};
		MEMBER("properties",_prop);
		deleteVehicle _unit;
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
				"FORM"
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

UCD_fnc_cacheable = {
	CHECK_THIS;
	private ["_obj", "_cacheable"];
	_obj = _this select 0;
	_cacheable = ["", false, false, -1];
	if (!(isNil "_obj") && {!isNull _obj} && {local _obj} && {alive _obj} && {!(isPlayer _obj)} && {_obj getVariable ["cacheObject", true]}) then {
		{ // forEach
			if (_obj isKindOf (_x select 0)) exitWith {
				_cacheable = _x;
			};
		} forEach UCD_cacheList;
	};
	_cacheable
};

UCD_fnc_cacheGroup = {
	CHECK_THIS;
	private ["_group"];
	_group = _this select 0;
	if (isNil {_group getVariable ["UCD_monitorScript", nil]}) then {
		_group setVariable ["UCD_monitorScript", ([_group] spawn UCD_fnc_cacheMonitor)];
	};
};

UCD_fnc_cacheObject = {
	CHECK_THIS;
	private ["_obj"];
	_obj = _this select 0;
	if ((local _obj) && {!isNull (group _obj)}) then {
		uisleep 2; // Let object init code process
		[(group _obj)] call UCD_fnc_cacheGroup;
		if (!isDedicated) then {waitUntil {!isNull player}}; // To avoid deletion of player unit
		private ["_cache"];
		while {true} do { // Only way to break loop is through exitWith
			if (_obj != (leader _obj)) then {
				_cache = [_obj] call UCD_fnc_cacheable;
				if (!(_cache select 1)) exitWith {};
				private ["_minDis"];
				_minDis = [_obj] call UCD_fnc_closestPlayerDis;
				if ((_minDis) > (_minDis call (_cache select 3))) exitWith {};
			};
			sleep CACHE_MONITOR_DELAY;
		};
		if (_cache select 1) then {
			if (_obj isKindOf "Man") then { // Unit
				[_obj, (_cache select 2), (_cache select 3)] call UCD_fnc_cacheUnit;
			} else { // Vehicle
				[_obj, (_cache select 2), (_cache select 3)] call UCD_fnc_cacheVehicle;
			};
		};
	};
};

UCD_fnc_cacheUnit = {
	CHECK_THIS;
	private ["_unit", "_unitVehPos", "_cache"];
	_unit = _this select 0;
	_cache = ["", true, DEFAULT_PARAM(1,false), DEFAULT_PARAM(2,{GLOBAL_SPAWN_DISTANCE})];
	_unitVehPos = _unit call UCD_fnc_unitVehPos;
	{ // forEach
		if ((_x select 0) == (_unitVehPos select 0)) exitWith {
			_cache = _x;
		};
	} forEach UCD_cacheList;
	if (_cache select 1) then {
		private ["_group", "_cachedUnit"];
		_group = group _unit;
		_cachedUnit = ["new", [_unit, (_cache select 2), (_cache select 3)]] call UCD_obj_cachedAsset;
		[_group, "UCD_cachedObjects", _cachedUnit] call UCD_fnc_push;
	};
};

UCD_fnc_cacheVehicle = { // Slightly experimental
	CHECK_THIS;
	private ["_veh", "_savePos", "_spawnDis", "_cache"];
	_veh = _this select 0;
	_savePos = DEFAULT_PARAM(1,false);
	_spawnDis = DEFAULT_PARAM(2,{GLOBAL_SPAWN_DISTANCE});
	if ((count (crew _veh)) > 0) then {
		private ["_group", "_endWait"];
		_group = group ((crew _veh) select 0);
		_endWait = diag_tickTime + CACHE_VEH_TIMEOUT;
		waitUntil {
			sleep 1;
			(isNull _veh) || {(count (crew _veh)) == 0} || {!alive _veh} || {diag_tickTime > _endWait};
		};
		if (!(isNull _veh) && {alive _veh} && {(count (crew _veh)) == 0}) then {
			private ["_cachedVeh"];
			_cachedVeh = ["new", [_veh, _savePos, _spawnDis]] call UCD_obj_cachedAsset;
			[_group, "UCD_cachedObjects", _cachedVeh] call UCD_fnc_push;
		};
	};
};

UCD_fnc_checkCache = {
	CHECK_THIS;
	private ["_refObj", "_cachedObjects", "_nonCachedObjects"];
	_refObj = _this select 0;
	_cachedObjects = +(_this select 1);
	_nonCachedObjects = [];
	if ((count _cachedObjects) > 0) then {
		private ["_minDis"];
		_minDis = [_refObj] call UCD_fnc_closestPlayerDis;
		if (_minDis >= 0) then {
			{ // forEach
				if ((_minDis call (["get", ["spawnDis", 0]] call _x)) >= _minDis) then {
					_nonCachedObjects = _nonCachedObjects + [_x];
					_cachedObjects set [_forEachIndex, objNull];
				};
			} forEach _cachedObjects;
		};
	};
	[_nonCachedObjects, (_cachedObjects - [objNull])]; // [toSpawn, toDoNothing]
};

UCD_fnc_cacheMonitor = {
	CHECK_THIS;
	private ["_group"];
	_group = _this select 0;
	while {!(isNil "_group") && {!isNull _group} && {(count (units _group)) >= 0} && {!isNil {_group getVariable ["UCD_monitorScript", nil]}}} do {
		private ["_objects"];
		_objects = [(leader _group), (_group getVariable ["UCD_cachedObjects", []])] call UCD_fnc_checkCache;
		{ // forEach
			["spawn", (getPos (leader _group))] call _x;
			["delete", _x] call UCD_obj_cachedAsset;
		} forEach (_objects select 0);
		_group setVariable ["UCD_cachedObjects", (_objects select 1)];
		uisleep CACHE_MONITOR_DELAY;
		waitUntil {!isNil "UCD_distributeAI"};
		if (isServer && {UCD_distributeAI} && {(count UCD_headlessClients) > 0} && {local (leader _group)}) exitWith {
			private ["_hc"];
			_hc = UCD_headlessClients select random((count UCD_headlessClients) - 1); // Equal probability distribution?
			[_group, (_hc select 1)] call UCD_fnc_sendGroup;
		};
	};
	_group setVariable ["UCD_monitorScript", nil];
};

/*
	Group: Initialization Code
*/

if (isServer) then {
	UCD_spawnUnitInit = CACHE_UNIT_SPAWN_FNC;
	UCD_distributeAI = CACHE_DISTRIBUTE_AI;
	publicVariable "UCD_distributeAI";
	publicVariable "UCD_spawnUnitInit";
};
