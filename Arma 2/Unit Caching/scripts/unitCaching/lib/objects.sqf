/*
	Title: Object Library
	Author: Dylan Plecki (Naught)
	
	License:
		Copyright © 2013 Dylan Plecki. All rights reserved.
		Except where otherwise noted, this work is licensed under CC BY-NC-ND 4.0,
		available for reference at <http://creativecommons.org/licenses/by-nc-nd/4.0/>.
*/

/*
	Group: General Functions
*/

UCD_fnc_getPos = {
	CHECK_THIS;
	private ["_thing"];
	_thing = _this select 0;
	switch (typeName _thing) do {
		case "OBJECT": {getPos _thing};
		case "STRING": {getMarkerPos _thing};
		case "ARRAY": {getWPPos _thing};
		default {[0,0,0]};
	};
};

/*
	Group: Player Functions
*/

UCD_fnc_closestPlayerDis = {
	CHECK_THIS;
	private ["_ref", "_minDis"];
	_ref = [_this select 0] call UCD_fnc_getPos;
	_minDis = -1;
	{ // forEach
		private ["_dis"];
		_dis = _x distance _ref;
		if ((_dis < _minDis) || {_minDis < 0}) then {
			_minDis = _dis;
		};
	} forEach (call CBA_fnc_players);
	_minDis
};

/*
	Group: Vehicle Functions
*/

UCD_fnc_unitVehPos = {
	/* ----------------------------------------------------------------------------
	Function: UCD_fnc_unitVehPos (ripped from ACE_fnc_unitvehpos)
	
	Notice:
		This function was taken from the ACE 2 Arma modification in order to modify
		an integral function of the script (always return 1 array element) and to
		reduce dependency. All credit goes to its respective authors, and all code
		within this function is licensed under the ACE 2 license as of 12/19/2013.

	Description:
		Function to retrieve unit position in vehicle, analogous to
		assignedvehiclerole but more reliable.
		
	Parameters:
		unit
		
	Returns:
		["None"] - on foot
		["Commander"] - commander 
		["Gunner"] - gunner 
		["Driver"] - driver 
		["Cargo"] - cargo 
		["Turret", [turret path]] - turret
		
	Examples:
		(begin example)
			_vehpos = player call ACE_fnc_unitvehpos
		(end)
		
	Author:
		(c) q1184/Rocko 
	---------------------------------------------------------------------------- */
	#define __cfg (configFile >> "CfgVehicles" >> (typeof _v) >> "turrets")
	private ["_u","_v","_tc","_tp","_st","_stc","_ptp","_res","_fn"];
	_fn = {
		private ["_c","_tc","_ar","_fn","_ind","_cnt","_cur"];
		_c = _this select 0;
		_ar = _this select 1;
		_fn = _this select 2;
		_ind = _this select 3;
		_tc  = count _c;
		_cnt = -1;
		if (_tc > 0) then {
			for "_i" from 0 to (_tc-1) do {
				if (isclass (_c select _i)) then {
					_cnt = _cnt+1;
					_cur = +_ind;
					_cur set [count _cur,_cnt];
					_ar set [count _ar,_cur];
					if (isclass ((_c select _i)>>"turrets")) then {[(_c select _i)>>"turrets",_ar,_fn,_cur] call _fn};
				};
			};
		};
		_ar	
	};
	_u = _this;
	_v = vehicle _u;
	if (_u == _v) exitwith {["None"]};
	_tp = [__cfg,[],_fn,[]] call _fn;
	//diag_log _tp;
	_ptp = [];
	{if (_u == _v turretUnit _x) exitwith {_ptp = _x}} foreach _tp;
	if (count _ptp > 0) then {
		_res = ["Turret",_ptp];
	} else {
		_res = switch (true) do { // redundant for safety
			case (_u == commander _v): {["Commander"]};
			case (_u == gunner _v): {["Gunner"]};
			case (_u == driver _v): {["Driver"]};
			default {["Cargo"]};
		};
	};
	_res
};