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
	private ["_group", "_mID"];
	_group = _this select 0;
	_mID = _this select 1;
	if (!(isNil "_group") && {!isNull _group} && {(count (units _group)) > 0}) then {
		private ["_cachedObjects", "_leader"];
		if (!isNil {_group getVariable ["UCD_monitorScript", nil]}) then {
			_group setVariable ["UCD_monitorScript", nil];
		};
		_cachedObjects = +(_group getVariable ["UCD_cachedObjects", []]);
		_group setVariable ["UCD_cachedObjects", []];
		{ // forEach
			if (!(isNil "_x") && {!isNull _x} && {alive _x} && {_x != (leader _group)}) then {
				_cachedObjects set [(count _cachedObjects), (["new", [_x, true, {-1}]] call UCD_obj_cachedAsset)];
			};
		} forEach (units _group);
		{ // forEach
			if (typeName(_x) == "CODE") then {
				_cachedObjects set [_forEachIndex, (["copy"] call _x)];
			};
		} forEach _cachedObjects;
		_leader = ["new", [(leader _group), true, {-1}]] call UCD_obj_cachedAsset;
		UCD_transferGroup = [ // [group, leader, [cachedObjects]]
			_group,
			(["copy"] call _leader),
			_cachedObjects
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
	private ["_cpy", "_cacheObj"];
	_cpy = _this select 0;
	_cacheObj = ["new"] call UCD_obj_cachedAsset;
	["copy", _cpy] call _cacheObj;
	_cacheObj
};

UCD_fnc_spawnTransferObj = {
	private ["_group", "_cacheObj", "_prevPos", "_obj"];
	_group = _this select 0;
	_cacheObj = _this select 1;
	_prevPos = _this select 2;
	_obj = objNull;
	if ((call (["get", ["spawnDis", {-1}]] call _cacheObj)) < 0) then {
		_obj = ["spawn", _prevPos] call _cacheObj;
		["delete", _cacheObj] call UCD_obj_cachedAsset;
	} else {
		[_group, "UCD_cachedObjects", _cacheObj] call UCD_fnc_push;
	};
	_obj
};

UCD_fnc_receiveGroup = {
	CHECK_THIS;
	private ["_var", "_val", "_group", "_leader", "_cachedObjects", "_leaderObj", "_prevPos"];
	_var = _this select 0;
	_val = +(_this select 1);
	_group = _val select 0;
	_leader = _val select 1;
	_cachedObjects = _val select 2;
	_leaderObj = [_leader] call UCD_fnc_copyCachedObj;
	_prevPos = ["get", ["position", [0,0,0]]] call _leaderObj;
	_group selectLeader ([_group, _leaderObj, _prevPos] call UCD_fnc_spawnTransferObj);
	{ // forEach
		if (typeName(_x) == "ARRAY") then {
			[_group, ([_x] call UCD_fnc_copyCachedObj), _prevPos] call UCD_fnc_spawnTransferObj;
		};
	} forEach _cachedObjects;
	/* Note: Group cache monitor loads on units' spawns automatically */
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
	UCD_broadcastHC = _this;
	publicVariableServer "UCD_broadcastHC";
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