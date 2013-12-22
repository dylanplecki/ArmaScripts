/*
	Title: Distribution Library
	Author: Dylan Plecki (Naught)
	
	License:
		Copyright © 2013 Dylan Plecki. All rights reserved.
		Except where otherwise noted, this work is licensed under CC BY-NC-ND 4.0,
		available for reference at <http://creativecommons.org/licenses/by-nc-nd/4.0/>.
*/

/*
	Group: Distribution Functions
*/

UCD_fnc_sendGroup = {
	CHECK_THIS;
	private ["_grp", "_mID"];
	_grp = _this select 0;
	_mID = _this select 1;
	if (!(isNil "_grp") && {!isNull _grp} && {(count (units _grp)) > 0}) then {
		private ["_cachedObjects", "_vehs", "_leader", "_waypoints"];
		if (!isNil {_group getVariable ["UCD_monitorScript", nil]}) then {
			//terminate [_group] spawn UCD_fnc_cacheMonitor;
			_group setVariable ["UCD_monitorScript", nil];
		};
		_cachedObjects = _group getVariable ["UCD_cachedObjects", []];
		_vehs = [];
		{ // forEach
			if (!(isNil "_x") && {!isNull _x} && {alive _x} && {_x != (leader _grp)}) then {
				if (((vehicle _x) != _x) && {!(vehicle _x in _vehs)}) then {
					_vehs = _vehs + [vehicle _x];
				};
				_cachedObjects = _cachedObjects + [(["new", [_x, true, {-1}]] call UCD_obj_cachedAsset)];
			};
		} forEach (units _grp);
		{ // forEach
			if (!(isNil "_x") && {!isNull _x} && {alive _x}) then {
				_cachedObjects = _cachedObjects + [(["new", [_x, true, {-1}]] call UCD_obj_cachedAsset)];
			};
		} forEach _vehs;
		{ // forEach
			if (typeName(_x) == "CODE") then {
				_cachedObjects set [_forEachIndex, (["copy"] call _x)];
			};
		} forEach _cachedObjects;
		_leader = ["new", [(leader _grp), true, {-1}]] call UCD_obj_cachedAsset;
		_waypoints = [];
		{ // forEach
			_waypoints = _waypoints + [[
				waypointBehaviour _x,
				waypointCombatMode _x,
				waypointCompletionRadius _x,
				waypointDescription _x,
				waypointFormation _x,
				waypointPosition _x,
				waypointScript  _x,
				waypointSpeed _x,
				waypointStatements _x,
				waypointTimeout _x,
				waypointType _x,
				waypointVisible _x
			]];
		} forEach (waypoints _grp);
		UCD_transferGroup = [ // [side, leader, [cachedObjects], [waypoints], currentWaypointIdx]
			(side _grp),
			(["copy"] call _leader),
			_cachedObjects,
			_waypoints,
			((currentWaypoint _grp) - 1)
		];
		if (_mID < 0) then {
			publicVariableServer "UCD_transferGroup";
		} else {
			_mID publicVariableClient "UCD_transferGroup";
		};
		true;
	} else {false};
};

UCD_fnc_copyCachedObj = {
	private ["_grp", "_cpy", "_cacheObj"];
	_grp = _this select 0;
	_cpy = _this select 1;
	_cacheObj = ["new"] call UCD_obj_cachedAsset;
	["copy", _cpy] call _cacheObj;
	["insert", ["group", _grp]] call _cacheObj;
	_cacheObj
};

UCD_fnc_spawnTransferObj = {
	private ["_group", "_cacheObj", "_prevPos", "_obj"];
	_group = _this select 0;
	_cacheObj = _this select 1;
	_prevPos = _this select 2;
	_obj = objNull;
	if ((-1 call (["get", ["spawnDis", {-1}]] call _cacheObj)) < 0) then {
		_obj = ["spawn", _prevPos] call _cacheObj;
		["delete", _cacheObj] call UCD_obj_cachedAsset;
	} else {
		[_group, "UCD_cachedObjects", _cacheObj] call UCD_fnc_push;
	};
	_obj
};

UCD_fnc_receiveGroup = {
	CHECK_THIS;
	private ["_var", "_val", "_side", "_leader", "_cachedObjects", "_waypoints", "_currentWP",
			"_cachedUnits", "_grp", "_leaderObj", "_prevPos", "_grpLeader"];
	_var = _this select 0;
	_val = +(_this select 1);
	_side = _val select 0;
	_leader = _val select 1;
	_cachedObjects = _val select 2;
	_waypoints = _val select 3;
	_currentWP = _val select 4;
	_cachedUnits = [];
	_grp = createGroup _side;
	_leaderObj = [_grp, _leader] call UCD_fnc_copyCachedObj;
	_prevPos = ["get", ["position", [0,0,0]]] call _leaderObj;
	{ // forEach
		if (typeName(_x) == "ARRAY") then {
			private ["_cacheObj"];
			_cacheObj = [_grp, _x] call UCD_fnc_copyCachedObj;
			if (["get", ["isVehicle", false]] call _cacheObj) then {
				[_grp, _cacheObj, _prevPos] call UCD_fnc_spawnTransferObj;
			} else {
				_cachedUnits = _cachedUnits + [_cacheObj];
			};
		};
	} forEach _cachedObjects;
	_grpLeader = [_grp, _leaderObj, _prevPos] call UCD_fnc_spawnTransferObj;
	_grp selectLeader _grpLeader;
	{ // forEach
		[_grp, _cacheObj, _prevPos] call UCD_fnc_spawnTransferObj;
	} forEach _cachedUnits;
	{ // forEach
		private ["_wp"];
		_wp = _grp addWaypoint [(_x select 6), 0];
		_wp setWaypointBehaviour (_x select 1);
		_wp setWaypointCombatMode (_x select 2);
		_wp setWaypointCompletionRadius (_x select 3);
		_wp setWaypointDescription (_x select 4);
		_wp setWaypointFormation (_x select 5);
		//_wp setWaypointPosition (_x select 6); // Already done above
		_wp setWaypointScript  (_x select 7);
		_wp setWaypointSpeed (_x select 8);
		_wp setWaypointStatements (_x select 9);
		_wp setWaypointTimeout (_x select 10);
		_wp setWaypointType (_x select 11);
		_wp setWaypointVisible (_x select 12);
	} forEach _waypoints;
	/*
	// Below may not work due to BI's confused currentWaypoint function
	if ((_currentWP > 0) && (_currentWP <= (count (waypoints _grp)))) then {
		_grp setCurrentWaypoint [_grp, _currentWP];
	};
	*/
	[_grp] call UCD_fnc_cacheGroup;
};

UCD_fnc_receiveHC = {
	CHECK_THIS;
	private ["_var", "_val", "_unit"];
	_var = _this select 0;
	_val = +(_this select 1); // [playerUnit]
	_unit = _val select 0;
	[missionNamespace, "UCD_headlessClients", [
		_unit,
		(owner _unit),
		(getPlayerUID _unit)
	]] call UCD_fnc_push;
};

UCD_fnc_broadcastHC = {
	CHECK_THIS;
	private ["_unit"];
	_unit = _this select 0;
	if (!isDedicated && !hasInterface) then { // Headless Client
		UCD_broadcastHC = [_unit];
		publicVariableServer "UCD_broadcastHC";
	};
};

UCD_fnc_onkilledHC = {
	private ["_unit", "_killer"];
	_unit = _this select 0;
	_killer = _this select 1;
	if (isServer) then {
		{ // forEach
			if ((_x select 0) == _unit) exitWith {
				[UCD_headlessClients, _forEachIndex] call UCD_fnc_uErase;
			};
		} forEach UCD_headlessClients;
	};
	if (!isDedicated && !hasInterface) then { // Headless Client
		waitUntil {!(isNull player) && {alive player}};
		[player] call UCD_fnc_broadcastHC;
	};
};

/*
	Group: Initialization Code
*/

"UCD_transferGroup" addPublicVariableEventHandler UCD_fnc_receiveGroup;
"UCD_broadcastHC" addPublicVariableEventHandler UCD_fnc_receiveHC;

if (isServer) then {
	UCD_headlessClients = [];
};

if (!isDedicated && !hasInterface) then { // Headless Client
	[] spawn {
		waitUntil {!isNil "UCD_serverInit" && {!isNull player}};
		player addMPEventHandler ["MPKilled", {_this spawn UCD_fnc_onkilledHC}];
		[player] call UCD_fnc_broadcastHC;
	};
};